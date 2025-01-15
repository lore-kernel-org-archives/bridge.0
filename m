Received: from mail.systec-electronic.com (mail.systec-electronic.com [77.220.239.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F308B2459CF
	for <bridge@lists.linux.dev>; Wed, 15 Jan 2025 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.220.239.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736947290; cv=none; b=psBT+nMTrnTVlJHMWGBf+Ihtp+ueTs6Lo6jJDoruA0FiZWQ5gzYX98hi8m7jt92LeTHAqEOO8sQsYkbowf4rukH5uLyV2O5aDO5mfsQz0ZOsxp9yComG4coLqRg58LFy9MDjQLX85S89ZaPn2IAiVlpfEFcbLVn/p8QT/eEK91Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736947290; c=relaxed/simple;
	bh=CFeAQQr6u5irfjBJM3EZI4AfC4FbP4kEbXHv7HgdrzE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=BR6014YZ+nAT108jC08KmqzrG7x4ZtMU053IwqmUDUovcDnQf3vO1zLfJHvSOO142l1uTK3nqSw7NaoT8zq/XxkHDG6dXPcdV6mTUIG418P2lUDHRUd9BZWBhp/aLm+lvpnkZrupyLOywYGRfM6dDDOOyqp0QYs2NC6GLImcgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com; spf=pass smtp.mailfrom=systec-electronic.com; dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b=e5IC6Let; arc=none smtp.client-ip=77.220.239.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=systec-electronic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=systec-electronic.com header.i=@systec-electronic.com header.b="e5IC6Let"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 4BB92941A5C4;
	Wed, 15 Jan 2025 14:21:23 +0100 (CET)
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5ymA2LUC3e9l; Wed, 15 Jan 2025 14:21:23 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.systec-electronic.com (Postfix) with ESMTP id 1CBD9941A5C5;
	Wed, 15 Jan 2025 14:21:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.systec-electronic.com 1CBD9941A5C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=systec-electronic.com; s=B34D3B04-5DC7-11EE-83E3-4D8CAB78E8CD;
	t=1736947283; bh=JSIrwnxacDPodmvPMEG4J36AYzJxVWxAkxBv2rPi11c=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=e5IC6LetpWsBBtrXtfew8KwFrhz7AYEDYIx1L32+AHrEKTsxpZOtc6V3wL7meoffF
	 iPYR2P95bW8XIkjtxht9IYL1Pw+tBwDSU/+ELCDDI/mqs96rPKssZEIg2rdi9oXAfb
	 jbxuorJq6Q5C+Vp05YVU9TQaXWPk3xkjgYdxis2eylYSinWFB6AtPfBJH66WHJxFXq
	 jlF9YDJ5bDd0QWstC6PRjI71x4l1+wc5PMukAWaAZrueuJsF1RBL4AeSoOSZkz0OXa
	 R/aKMsjsGoLl2F4RSuPVF6zcBSqqQ/FGkNSRIxOSre81YiXPFWcjgDZC8SuVZfntPF
	 BnCalurJNaJ8g==
X-Virus-Scanned: amavis at systec-electronic.com
Received: from mail.systec-electronic.com ([127.0.0.1])
 by localhost (mail.systec-electronic.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id xhWrME2EW52w; Wed, 15 Jan 2025 14:21:23 +0100 (CET)
Received: from lt-278851.systec.local (unknown [212.185.67.148])
	by mail.systec-electronic.com (Postfix) with ESMTPSA id DD407941A5C4;
	Wed, 15 Jan 2025 14:21:22 +0100 (CET)
Date: Wed, 15 Jan 2025 14:21:22 +0100 (CET)
From: Andre Werner <andre.werner@systec-electronic.com>
Reply-To: Andre Werner <andre.werner@systec-electronic.com>
To: bridge@lists.linux.dev, netdev@vger.kernel.org, linux-net@vger.kernel.org
Subject: Redundancy Network Monitoring - How To?
Message-ID: <d4752eb8-3d21-fe4b-a0d2-06b311724d8c@systec-electronic.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463794929-1843351374-1736947282=:17662"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463794929-1843351374-1736947282=:17662
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Dear Readers,

I face a problem where I have not found an appropriate answer, yet.
I have a dedicated ring topology in a network. To simply manage opening
the ring we can use STP and its derivatives (e.g. mstpd). I also found th=
at
there is support for Media Redundancy Protocol (MRP) in the Linux kernel
which may fit my needs better. However, I'm wondering how to use it since
the bridge commands mentioned in the Patch have not been implemented yet,
although the first patch set was more than 3 years back. Moreover, in add=
ition
to automatic rerouting via other nodes in case of topology changes,
I need information about changes in the topology itself, even if the rout=
e
is currently not used. Is there any option provided in SW or even in the =
Kernel to
achieve this goal. It is a kind of predictive maintenance.

Thanks in advance.

Andr=E9
---1463794929-1843351374-1736947282=:17662--
