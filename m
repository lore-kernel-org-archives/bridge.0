Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012F71B46
	for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706645988; cv=none; b=tpmX5wz9k869ZmP40pcwIRQVOxDIMKdP8c6jmiW/efElEUjRO2r442EmBkoEXfeMtjPQcxyuac4GHe8qdjlpYZpT2Df5f9UFyUQsQdlTRJjTXYRWIdeM2bbYx/4QETuHpzYoyUmXD2XwR22KIJfinw7OS/JrXqHRPYUs49Nv+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706645988; c=relaxed/simple;
	bh=8QkojfAZ4GyPX8FnHuYihDcrR8rZGuZI5LZ7LzNs6Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gE77/RkLGT+ayZVZwRzUIlYWroN9exmzI6lzu2r6Mu4P4V9YBQejQ+DuAEM3yuTnemQJspdL0yTSEXDvg+LfzYlYBgYnrMugjbyF0xLCf/g9Ul2UxagufioRtbb7Fbn4qsQ8sZ+4k+g7GGZSwDb4MfV4VazAsKCKCyDlA2iGFOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=CF7WqIGy; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="CF7WqIGy"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5111ef545bfso1535982e87.1
        for <bridge@lists.linux.dev>; Tue, 30 Jan 2024 12:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706645984; x=1707250784; darn=lists.linux.dev;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79DhbYEIitTatIm4/tAarmxf5MelJGreTkXGurDLY4Q=;
        b=CF7WqIGyFZjpjtfkeaclcybMSSG9HFGWQ1nBuu2d5LC+4m/jZ2CZZhmF1D2DOCGbF4
         BLMdQQD2tN9WDnUBIGRdd8Y5hfnQNEl2N4AesxmVaTZd8ylGi/cXgHx9Jiu5we1i0sSq
         Itcn3OGvNBwBfno7pKKcv+vKR7df34uJklXms0Vog9N04787hAJEiwqC77cEdebz4EVr
         /yK5hJP3YpXNhURxDrNj7O3omr2JgSBLHiekcg4dRxGl48NPS6C3bMoa8+h1Y+dBQEr2
         Ot9hehU4Q8YF2MLCe4zzqE9g/Yc3PeYPgnxLpju4Zb5KmrVyPRRMnF5a+HLVFjCHqNSn
         Go2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706645984; x=1707250784;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79DhbYEIitTatIm4/tAarmxf5MelJGreTkXGurDLY4Q=;
        b=JODAjwBUJXQxNG1TZJ92OFaCHxSNFD6bNj+Tqpe2e/Tr9SDCZCrpVBNRH1ufY4uSFL
         Dd7Z5U8OUiogX1Emk6WR7eBvz41SLqMr0NJvHMFDv2jqVLmt5kEjyKQYNHzrh2abjYBx
         SfAupC9CXPgaSqsQnJLBWsfJ9LO6Vfg/yKPKkfxTx8Ihc5gHEWwsEfpUb2h3xfN9ybIs
         aBNTJEPO6IEH9fPfta62TuIuSE+HBV0Px1v3c+kVIxZlrYERw5gL9LBjozS+atKFoy71
         R+fPxC94ftH2PYatJhGb9nUipxd3Pm4z+4wJVOal4NPiF4qahNcIWNcZxWyXIL3kLT5F
         wQbQ==
X-Gm-Message-State: AOJu0YwqQmndtX+wXqQ6K3EIDj55NLDfyk8GFAyY0/Rq8p3zPZ4eTTK3
	GM9i9HZVm/2gpqFhHdM+/6ktsMxJTmxiGSurv+2pIcSFhSoOPukx+0Jno5LZabE=
X-Google-Smtp-Source: AGHT+IFcpy16WZn10cX85Jp9+Osxwf+seUK0vNsm3MW1ezb/i78gUe5mMGps8IPc9IDOA15iu0Esng==
X-Received: by 2002:a05:6512:401c:b0:50e:7bc5:20d8 with SMTP id br28-20020a056512401c00b0050e7bc520d8mr8058352lfb.4.1706645983936;
        Tue, 30 Jan 2024 12:19:43 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056512480f00b0051011f64e1bsm1553239lfb.142.2024.01.30.12.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:19:43 -0800 (PST)
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
Subject: [PATCH v2 net-next 0/5] net: switchdev: Tracepoints
Date: Tue, 30 Jan 2024 21:19:32 +0100
Message-Id: <20240130201937.1897766-1-tobias@waldekranz.com>
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

v1 -> v2:

- Fixup kernel-doc comment for switchdev_call_replay

I know that there are still some warnings issued by checkpatch, but
I'm not sure how to work around them, given the nature of the mapper
macros. Please advise.

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

