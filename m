Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AD63876C3
	for <bridge@lists.linux-foundation.org>; Mon,  9 Feb 2026 17:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770657611; cv=none; b=nf1QYEWTrciiguCC73/EOsAVe07081OEiAkvZF4JHCEDQ4+1FLWT30hLd6JwV1Lch3mihbHsO4AVipU6OqUbO5qyMoQ/t6eY8OSb9h28ExKtVRblDmYI3qw7wsKwthbHtOlKmjr1i8iz1Bn0cdeICVhtSidYga0sxfYpoUKAXkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770657611; c=relaxed/simple;
	bh=jPLQs3Hdny0FP3l+/5Ri3BVUh5isgpNkxUZ/B/5gKvQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abV8u5SlWQas433Lstux4pPLzrF8KLVQrGXfFcDF0t6hkBnL42YOSbJUAW+j5Yrz2tLCrYv3hsGks3pPdtdKaa6bRrYqG0Bq/hQXmcZc5h6tFuVddS041cBifrBf7OhX1z3lccMzCEYpM//nN5D1GGwU3IE21IW8eJcxxUX/LOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=airn.giize.com header.i=program@airn.giize.com header.b=QzJLKla5; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airn.giize.com header.i=program@airn.giize.com header.b="QzJLKla5"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 46830816FD
	for <bridge@lists.linux-foundation.org>; Mon,  9 Feb 2026 17:20:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: 0.992
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ODOYS6ZT3waE for <bridge@lists.linux-foundation.org>;
 Mon,  9 Feb 2026 17:20:10 +0000 (UTC)
X-Greylist: delayed 604 seconds by postgrey-1.37 at util1.osuosl.org; Mon, 09 Feb 2026 17:20:09 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8B16F816FB
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=reject dis=none) header.from=airn.giize.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B16F816FB
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=airn.giize.com header.i=program@airn.giize.com header.a=rsa-sha1 header.s=default header.b=QzJLKla5
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=143.20.185.112; helo=mta0.airn.giize.com; envelope-from=program@airn.giize.com; receiver=<UNKNOWN> 
Received: from mta0.airn.giize.com (mta0.airn.giize.com [143.20.185.112])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8B16F816FB
	for <bridge@lists.linux-foundation.org>; Mon,  9 Feb 2026 17:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=default; d=airn.giize.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=program@airn.giize.com;
 bh=LQD0hXllgKXRJZ7cLKh8fnQZqgQ=;
 b=QzJLKla5wErB4YNoqgyTzchdiD6ttg7TIMRIAHaUqf8e+1EI14MKsFTfq+CR2DPCpnUEiM4ITiMu
   9netZUVTzAC1zSBszU3PhRfM5xgAbry5kwHACR0mFUoNb0wNwm81Bvwx5Y1ZhahnLQDomJNDoK+D
   QKaC0Htdk6aIZGTr7xw=
Reply-To: sales@sslootah.cam
From: S.S. Lootah Trading <program@airn.giize.com>
To: bridge@lists.linux-foundation.org
Subject: RE: Inquiry for Product Information
Date: 9 Feb 2026 09:09:59 -0800
Message-ID: <20260209090959.C3957E3D2F4AC5BF@airn.giize.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Sir,
Good day.

We are currently reviewing manufacturers for upcoming projects=20
and would like to request your latest product catalog or=20
brochure, including key specifications, pricing details, payment=20
terms, and estimated delivery timelines.

Kindly send the requested information to sales@sslootah.cam at=20
your earliest convenience.

Thank you for your time. We look forward to your response.



Best regards,

Mohamed El-Sayed | Head of projects
S.S. Lootah Trading Building Material Division LLC
P.O. Box: 33919, Dubai =E2=80=93 UAE
T +971 4 775 4880
F +971 4 775 4881
M +971526792040
E sales@sslootah.cam
