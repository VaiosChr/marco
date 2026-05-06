module.exports = (req, res, next) => {
  // ── CORS headers (useful during Flutter dev) ──────────────────────────────
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization');
  res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, PATCH, DELETE, OPTIONS');
  if (req.method === 'OPTIONS') return res.sendStatus(200);

  // ── Normalize Path ────────────────────────────────────────────────────────
  let path = req.path;

  if (path === '/api/otp/request' || path === '/api/otp/verify') {
    path = '/otp_requests';
  } else {
    // Remove the /api prefix and convert hyphens to underscores
    path = path.replace(/^\/api/, '').replace(/-/g, '_');
  }

  // ── POST /api/otp/request  →  always succeed, return mock OTP id ──────────
  if (req.method === 'POST' && path === '/otp_requests' && req.query.action !== 'verify') {
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
  if (req.method === 'POST' && path === '/otp_requests' && req.query.action === 'verify') {
    const { code } = req.body || {};
    if (/^\d{6}$/.test(code)) {
      return res.status(200).json({ verified: true, message: 'Phone verified successfully.' });
    }
    return res.status(400).json({ verified: false, message: 'Invalid OTP. Must be 6 digits.' });
  }

  // ── POST /api/sessions (login)  →  naive email/password check ────────────
  if (req.method === 'POST' && path === '/sessions') {
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
  if (req.method === 'GET' && path === '/route_status' && req.query.routeId) {
    const safety     = +(6 + Math.random() * 4).toFixed(1);          // 6–10
    const airQuality = +(3 + Math.random() * 7).toFixed(1);          // 3–10
    const noiseDb    = Math.floor(45 + Math.random() * 40);          // 45–85

    let totalPenalty = 0;

    if (safety < 8.0) {
      totalPenalty += (8.0 - safety) * 12; // Lower safety = higher penalty rate
    }

    if (airQuality < 6.5) {
      totalPenalty += (6.5 - airQuality) * 10;
    }

    if (noiseDb > 70) {
      totalPenalty += (noiseDb - 70) * 1.5; // Penalty increases with decibels above 70
    }

    let overallStatus = 'GOOD';
    
    if (totalPenalty >= 35) {
      overallStatus = 'ALERT';
    } else if (totalPenalty >= 15) {
      overallStatus = 'CAUTION';
    }

    return res.status(200).json({
      id: `rs_live_${Date.now()}`,
      routeId: req.query.routeId,
      safety: parseFloat(safety),
      airQuality: parseFloat(airQuality),
      noiseDb: parseInt(noiseDb),
      overallStatus,
      metricsScore: Math.max(0, Math.min(100, Math.floor(100 - totalPenalty))), // Useful secondary metric
      updatedAt: new Date().toISOString()
    });
  }

  // ── POST /api/suggestion-feedback  →  echo back with points awarded ───────
  if (req.method === 'POST' && path === '/suggestion_feedback') {
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
  if (req.method === 'POST' && path === '/trip_logs') {
    const { routeTaken } = req.body || {};
    let pointsEarned = 10; // base for any trip log
    if (routeTaken === 'suggested') pointsEarned = 50;
    req.body.pointsEarned = pointsEarned;
    req.body.createdAt    = new Date().toISOString();
    // fall through to json-server to persist it
  }

  next();
};