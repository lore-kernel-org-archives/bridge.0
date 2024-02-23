Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BF378661
	for <bridge@lists.linux.dev>; Fri, 23 Feb 2024 11:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688812; cv=none; b=MYIg+tLK7xw9psW38OaC77+95uT/FkQ7YlpeMBBdYJdXYQ/Fx8GYPfdI65VDyW14LXqLB/4GpneAdsOz2qPzGpq7IxBJwTeK/S+rsNlWOhu3Het4hO8ePHs8qkWlMBE45UHWQnFd9yXICbYvkgllKsC0/were2P/GasGsJR6gXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688812; c=relaxed/simple;
	bh=wKwKA0p4vt6AwTeHwXt7AVmIzq29IsV/+yie3gcAHZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iazr0PeJyb8u89KD5IGvt8ANAXx8PJHOh9ZSd3pua3lQZOlXq4/HC7lsf3WLdSw+nyiPdGnIU2DKqbu962Gu+4GBohXMLhLx6GYZnj0RjF0tL3YQKVt9by+ajLZg4Yh3bNy3q2eF3rNpmkBJz3FPG/Lc/UBqVCpoTxIA76VJUUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=rxcB4D5c; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="rxcB4D5c"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512bb2ed1f7so275428e87.3
        for <bridge@lists.linux.dev>; Fri, 23 Feb 2024 03:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708688808; x=1709293608; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UYaGIlRWtlH5yr29hsAr3bMxvcE9aO0b9v1PXvyEfT0=;
        b=rxcB4D5cFKitBO0Zh/mDivnGjxtyBdhAl2cGR+6V/XdHcjDkX+oSHxGKMBuJKQiitM
         GJGZe3O6KsxE4iQFkLGEf5lxdCf9FHSh9kFrBj73nvnzHDdjba7/ZSdjMbnstN6OLz3z
         cxPEdvnFy8W7bNnh53VHltY1mLUgQgVQ9Aak4/zTDSPt5pW9RMDlM8baOcgh9KGD6HAy
         ozyc7Son3FTjMQkqV/IC92MBgI0zGVNzhNZhnRCIF3ZSK8WRn2R8tLsHl46hrVu6s+A+
         WWVdX9Di7oCaWxoJMBZmnhDoffZF6UYzGn4U9gsd05wOQIlDJBaZFgzXBEqGYXUJWGEK
         l1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708688808; x=1709293608;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYaGIlRWtlH5yr29hsAr3bMxvcE9aO0b9v1PXvyEfT0=;
        b=RNV35Gcig0xXJ5vmcfoYcuAEdfq5NUgDttuDMK+hWCBrOJCpeFRMdze9Dd3dX+4/WT
         /5lpa/6g9Sc9Xu7U979kBYbuIh3xry+9cJGN4CFBC6J0bFKCGh99igsHkTRn83GkXcJY
         +4J1v9aS/QOcvapm0ebQEkQkfgiXTjpluSFg39BSvltIQobrjbcn/18WrlKgFaFWBkmf
         JZqnEgudJqLftFBQ/EOYizDKmJuJoIhaUET+PSFqyQQCO90ymXib6n48NLTafI++A/ky
         crwBLKk85T+UVvjqxsCtMkOQtRR8iCPpLW+EorW72v02t7I3VAY2iRu3MhJC/Ob03LfI
         dI4A==
X-Forwarded-Encrypted: i=1; AJvYcCVgXvoSj1jhBTYdXYGU57aKT6yU5mCm6Z4ALB4TIsAYNAfS/UbkTs7Je02z2tZPATc980Gtd1/PU/rV7wQD7jn+Li2c9H8I
X-Gm-Message-State: AOJu0Yz0WBa+8U8tSL6Rxjlf0/LKlHMW8HdIYlE0bChxYYz0/o1Rxehf
	M8IvyQ8CXVocpHJnnoH44w/xWLy6UESbeADxbo7dmou73jg3ytrWOStIOyyO/PY=
X-Google-Smtp-Source: AGHT+IH2mdJq53bkBO5sog527xIQE+kgKnqpGPuW5eYY2m4q0AZgoHvbR0Xl071UF67OKiEa7BV+SA==
X-Received: by 2002:ac2:58ce:0:b0:512:b437:4b06 with SMTP id u14-20020ac258ce000000b00512b4374b06mr1084775lfo.67.1708688807864;
        Fri, 23 Feb 2024 03:46:47 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id 11-20020ac25f0b000000b00512d180fd3asm1011694lfq.144.2024.02.23.03.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:46:47 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	ivecera@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 0/4] net: switchdev: Tracepoints
Date: Fri, 23 Feb 2024 12:44:49 +0100
Message-Id: <20240223114453.335809-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

Add a basic set of tracepoints to the switchdev layer that allows us
to monitor all messages being passed between a bridge and the devices
attached to it.

Deferred operations are additionally traced at the time they are
enqueued. This is useful in situations where we want to inspect the
conditions that lead to that message being generated, by looking at a
stacktrace for example.

Start off (1-2/4) by creating stringifiers for common switchdev
objects. This will primarily be used by the tracepoints for decoding
switchdev notifications, but drivers could also make use of them to
provide richer debug/error messages.

Then (3/4) create a common function through which all replay calls
pass, to create a natural point of instrumentation, before adding the
tracepoints themselves (4/4).

v2 -> v3:

Take a more conservative approach to the refactoring of
switchdev.c. In the end, I don't know that my previous attempt really
improved the situation much.

v1 -> v2:

- Fixup kernel-doc comment for switchdev_call_replay

Tobias Waldekranz (4):
  net: switchdev: Wrap enums in mapper macros
  net: switchdev: Add helpers to display switchdev objects as strings
  net: switchdev: Relay all replay messages through a central function
  net: switchdev: Add tracepoints

 include/net/switchdev.h          | 130 ++++++++++-----
 include/trace/events/switchdev.h |  74 ++++++++
 net/bridge/br_switchdev.c        |  10 +-
 net/switchdev/Makefile           |   2 +-
 net/switchdev/switchdev-str.c    | 278 +++++++++++++++++++++++++++++++
 net/switchdev/switchdev.c        |  87 +++++++++-
 6 files changed, 521 insertions(+), 60 deletions(-)
 create mode 100644 include/trace/events/switchdev.h
 create mode 100644 net/switchdev/switchdev-str.c

-- 
2.34.1

