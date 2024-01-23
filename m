Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF360DE0
	for <bridge@lists.linux.dev>; Tue, 23 Jan 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024252; cv=none; b=uzf8TQXBndTqOdb/AhCigVv0W6xcJelf7z/XKQKq0t1bHYndqdtbj+or7E64rYuPlBOzyDHwjBxB1tND4VmJi8Zx6dQ8Vt+4ngAP10898yj9JHL3o7+kSPNAefIrNOompAaPbXfvj2zMvP2V2Dyur1NYfi4B3S1EzV73eYL4lfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024252; c=relaxed/simple;
	bh=SmprmXJKPp6opHqPLLviYvms4SHFNPILVuQUb8Rwo/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i9ObmOMlQohLJHHVzEWtm/jcz2ZPWNATcm1JvJpjmP2kO9m0yKY6BBE5z7c5mjgNSzVxEtxnLN4X2V7brUuomkowZni/86Cd5RldVrIvEUY8aEcjFq2DMaIJKlxYTv8McKauoBLBYi3jPjTgszrxBVBiQDICXEv2ilmG38Nn1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=2YhF1p/3; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="2YhF1p/3"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5100893015fso862562e87.1
        for <bridge@lists.linux.dev>; Tue, 23 Jan 2024 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706024248; x=1706629048; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=veMMcsUebJYkhfmIXUs+5LrZbCXp0fVUgnh9FAkwwJ8=;
        b=2YhF1p/3q9Fq5oums74X3RWO08pRmZW/Dtv4Ox+HVtLWaf7fnD9jn/+xRfrQ7VdOVI
         xNJfR7H5z73TnJnKSgQC3zLNT/wwGmPYVBOz0YGwwOSL050sFIfSR+GvyDDoB/UdpuZK
         52xlHVHERJf3CQnwVdhe/hmJZxuTwGIUFj4YJhfIv9+l/t8J/Ii56nVhEv4VFPxfqauE
         jE9cgfGnahkMlgHrD91dvck34G1isqe09wso8diGdtN2u5yT4ewM3ym4tPh01g+MF2EB
         YNQTTI0tfzL0BGwX7r37sxu4O/9H/GSbQGMfKl0SS/3K3vivPxG/2Ag8TJCzFx0PTYB+
         7bkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024248; x=1706629048;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veMMcsUebJYkhfmIXUs+5LrZbCXp0fVUgnh9FAkwwJ8=;
        b=JMz94LKEexPoEhEDfr6z1mq8HawsDUMVd4vQnNqa8yfhiH5fvq8RNHvhGblyULrcN5
         L8NYwHbWKqPidpvF4uYbqQBk+G2F9f7pn7tirKmOIKARw/JnSq2hEfVpLoT3ujx+KZC8
         VyY6V4CWqj2DPjilxHrmUSHub8S3zgo4dBTo9N/95S8VV4SdmXAlNeMY9BM+1HfOXIMQ
         AnzABwXRebZl6uaQILc5U8lt/JClX0ZJDFdgNx0vpsbNOhVi+AJ1JXrS9Q1+YpQB6y6p
         AUUiG090mU9scxEvARpdExJV+8wklgXKIHtoxj389rhgMMPECA1kKpd4wwYuYpJEdHPB
         AaCw==
X-Gm-Message-State: AOJu0YywEpqa0tDKLqWlk2zNb4kV12T0vBBBJtQZbIjcCKBixwuBGtqc
	mZshUxeGlJtM9w/+L/E86ZS3TfClb3VIs7mfplLn1RhvLouoUPyXP++oTyK9Dvk=
X-Google-Smtp-Source: AGHT+IGhlL9oAnwBrOhrZJ0R/VfLySlP45A9B/Vc0ntm6DeD38WuWmDZF1mZUlXPMtYF7otvhtzzRA==
X-Received: by 2002:a05:6512:1295:b0:50e:ca83:887e with SMTP id u21-20020a056512129500b0050eca83887emr1948380lfs.34.1706024247144;
        Tue, 23 Jan 2024 07:37:27 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id h23-20020a19ca57000000b0050ee3e540e4sm2386790lfj.65.2024.01.23.07.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:37:26 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: jiri@resnulli.us,
	ivecera@redhat.com,
	netdev@vger.kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: switchdev: Tracepoints
Date: Tue, 23 Jan 2024 16:37:02 +0100
Message-Id: <20240123153707.550795-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This series starts off (1-2/5) by creating stringifiers for common
switchdev objects. This will primarily be used by the tracepoints for
decoding switchdev notifications, but drivers could also make use of
them to provide richer debug/error messages.

Then follows two refactoring commits (3-4/5), with no (intended)
functional changes:

- 3/5: Wrap all replay callbacks in br_switchdev.c in a switchdev
       function to make it easy to trace all of these.

- 4/5: Instead of using a different format for deferred items, reuse
       the existing notification structures when enqueuing. This lets
       us share a bit more code, and it unifies the data presented by
       the tracepoints.

Finally, add the tracepoints.

Tobias Waldekranz (5):
  net: switchdev: Wrap enums in mapper macros
  net: switchdev: Add helpers to display switchdev objects as strings
  net: switchdev: Relay all replay messages through a central function
  net: switchdev: Prepare deferred notifications before enqueuing them
  net: switchdev: Add tracepoints

 include/net/switchdev.h          | 130 ++++++++----
 include/trace/events/switchdev.h |  89 ++++++++
 net/bridge/br_switchdev.c        |  10 +-
 net/switchdev/Makefile           |   2 +-
 net/switchdev/switchdev-str.c    | 278 +++++++++++++++++++++++++
 net/switchdev/switchdev.c        | 346 +++++++++++++++++--------------
 6 files changed, 650 insertions(+), 205 deletions(-)
 create mode 100644 include/trace/events/switchdev.h
 create mode 100644 net/switchdev/switchdev-str.c

-- 
2.34.1

