// middleware.js
// json-server middleware for MARCO mock API
// Run with: json-server --watch db.json --routes routes.json --middlewares middleware.js --port 3000

module.exports = (req, res, next) => {
  // ── CORS headers (useful during Flutter dev) ──────────────────────────────
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE, OPTIONS');
  if (req.method === 'OPTIONS') return res.sendStatus(200);

  // ── POST /api/otp/request  →  always succeed, return mock OTP id ──────────
  if (req.method === 'POST' && req.path === '/otp_requests') {
    const phone = req.body?.phone || 'unknown';
    console.log(`[OTP] Sending mock OTP to ${phone}. Any 6-digit code will be accepted on verify.`);
    return res.status(200).json({
      id: `otp_${Date.now()}`,
      phone,
      message: 'OTP sent (mock). Use any 6-digit code.',
      expiresIn: 300
    });
  }

  // ── POST /api/otp/verify  →  accept any 6-digit code ─────────────────────
  if (req.method === 'POST' && req.path === '/otp_requests' && req.query.action === 'verify') {
    const { code } = req.body || {};
    if (/^\d{6}$/.test(code)) {
      return res.status(200).json({ verified: true, message: 'Phone verified successfully.' });
    }
    return res.status(400).json({ verified: false, message: 'Invalid OTP. Must be 6 digits.' });
  }

  // ── POST /api/sessions (login)  →  naive email/password check ────────────
  // Real auth is out of scope; this just returns a mock token so Flutter
  // can persist something locally.
  if (req.method === 'POST' && req.path === '/sessions') {
    const { email, password } = req.body || {};
    if (!email || !password) {
      return res.status(400).json({ error: 'email and password required' });
    }
    const token = `marco-token-${Date.now()}`;
    return res.status(201).json({
      id: `s_${Date.now()}`,
      token,
      parentId: 'p1', // demo parent; in a real server you'd look this up
      expiresAt: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString()
    });
  }

  // ── GET /api/route-status?routeId=X  →  return live-ish mock values ───────
  // Randomise values slightly so the Flutter app can simulate polling updates.
  if (req.method === 'GET' && req.path === '/route_status' && req.query.routeId) {
    const safety     = +(7 + Math.random() * 3).toFixed(1);          // 7–10
    const airQuality = +(5 + Math.random() * 5).toFixed(1);          // 5–10
    const noiseDb    = Math.floor(50 + Math.random() * 30);          // 50–80
    let overallStatus = 'OK';
    if (airQuality < 6 || safety < 7 || noiseDb > 70) overallStatus = 'CAUTION';
    if (airQuality < 4 || safety < 5 || noiseDb > 80) overallStatus = 'ALERT';

    return res.status(200).json({
      id: `rs_live_${Date.now()}`,
      routeId: req.query.routeId,
      safety,
      airQuality,
      noiseDb,
      overallStatus,
      updatedAt: new Date().toISOString()
    });
  }

  // ── POST /api/suggestion-feedback  →  echo back with points awarded ───────
  if (req.method === 'POST' && req.path === '/suggestion_feedback') {
    const { suggestionId, liked, stars } = req.body || {};
    const pointsEarned = liked ? 50 : 5;
    return res.status(201).json({
      id: `fb_${Date.now()}`,
      suggestionId,
      liked,
      stars: stars || null,
      pointsEarned,
      message: liked
        ? `Thanks for trying the suggestion! +${pointsEarned} pts`
        : 'Feedback recorded. We\'ll improve our suggestions!',
      createdAt: new Date().toISOString()
    });
  }

  // ── POST /api/trip-logs  →  calculate and attach pointsEarned ────────────
  if (req.method === 'POST' && req.path === '/trip_logs') {
    const { routeTaken } = req.body || {};
    let pointsEarned = 10; // base for any trip log
    if (routeTaken === 'suggested') pointsEarned = 50;
    req.body.pointsEarned = pointsEarned;
    req.body.createdAt    = new Date().toISOString();
    // fall through to json-server to persist it
  }

  next();
};
