Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB305101A
	for <bridge@lists.linux.dev>; Mon, 13 May 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715597657; cv=none; b=eHF2Exj8Fv0JR98a85ofjKXSq9E3ZrfTTY8cUBKzL70OsPAk8n8XLmEYwjlEJx7gx3iK4FUnO0m1EXQkDjMn/nJX6ec2YUFQrfIgbp0llUmlPCUCDpsCTgPmHa0mhRDnKviD+Tke7PvgpXddMWiTWp1vmQdd/LBS2eGtk/NISBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715597657; c=relaxed/simple;
	bh=Szhqf8ooS3BEnxzlJQIEQprMys0NYgaUTf6nvTDM9gA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wvgil2WBhr46hRANZcQj0p2c/J4iZDF+nmRiDCkFxy1OY17DilRgvjteCtkYOPreHPpRQNE2YkKVIYxrpynkShd9jUr/jn1sXWZo8/SkClrXZfuy4SYsFmMmBOjR+xwA93mUT96l4ncsBSOco6WcTuRKQFW4wKSKyAstebxalRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=aK041MGz; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="aK041MGz"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34eb52bfca3so3735474f8f.0
        for <bridge@lists.linux.dev>; Mon, 13 May 2024 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1715597654; x=1716202454; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QznyFO3rd2jTKjUKQdNYdAWkDeClk6MN0UCvUizPFTo=;
        b=aK041MGzP8C1Msed6w7u0oJvUeLKgtezZrIehyWqXWAS0O8GClNKQPL69dWVpP0iAN
         GdDk/WHDN17/Uzasxrb5EkHlIL87gdmFAzcjFMkCBPpHnTyEAEAmXdhVjaWcND5FtOYd
         8UnAhIml8Eyw+BRZPgFxysWQXz0MGN1pJesvkCXxHADxSkAU0RuZ0G/mbq/x+uvi1Is7
         2jzBK+nqCqH2YTzAR5WyaKGDHcHI+ZMCtho2SArOEwUJjQdHoCvlu82do5yzzBoWc0c4
         80lxJJIUy3N07M7LYnbUdGEBREkzJk+r3IXu74vIC5d7d59XdsuXjiCSJ9OHOA4cHw1N
         DOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715597654; x=1716202454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QznyFO3rd2jTKjUKQdNYdAWkDeClk6MN0UCvUizPFTo=;
        b=TJBEArNr4ylH93FvbbhVpKf0i5hY0CHPOipgFXt2vYmi9TYZNwylyHPhIm3px2g7pm
         aD2stp8RvTnF0RentLs6AFd18zSnyWnmtEQJ7f02pKsgcvxDCH0+LILzC/tHZJRnjV/f
         aX0JtycebkV6G17EB8lkCfBwCptVrdINRVKM0wg9qi5IAm1CBZJPT23SiNyBWOQq6yjw
         KQxCC9NyG5xCT8OUwEpzvlVLQ5CDUUcC4yn8JRO0ZmtYcs2ZvhG0qiutCzafheixFvM8
         t+OUhR9isEJYE3np34c5pqLlrXqcTHOKIj/BQ5WsmvyhAjuk9ZitMFWAGGVXTZ98XmXS
         fFLg==
X-Forwarded-Encrypted: i=1; AJvYcCW1iwuYIHw4bjYF+F9iAvXJ//GCvoJ1UbdLVCbZxY6MPANDnOpRsPm/Y7hdL22iBZa+nS2FTtMBO7HOo6+X/fEcc2Clxi0S
X-Gm-Message-State: AOJu0YwEflxFCz8dDzx2RAkpzas1FdDtKbpFKsm1d+tWcBgDw2R72D2O
	RRJVIwSy+YmS9nTpu4yQvWSfEPeBKbXAwiloqRrdND3MfgTl9Wrxeng0oRIUYTs=
X-Google-Smtp-Source: AGHT+IEXbqs6Pb+37F0hG90tB6d+LlaxcFt6/mbYceVpmrr4At3DbXjN5EY536uv7vYGDcnRNjRAoQ==
X-Received: by 2002:a05:6000:1042:b0:34c:54c8:3f2d with SMTP id ffacd0b85a97d-3504aa63858mr7314779f8f.69.1715597653869;
        Mon, 13 May 2024 03:54:13 -0700 (PDT)
Received: from debil.. ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacfd3sm10873420f8f.84.2024.05.13.03.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 03:54:13 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	roopa@nvidia.com,
	bridge@lists.linux.dev,
	edumazet@google.com,
	pabeni@redhat.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net] selftests: net: bridge: increase IGMP/MLD exclude timeout membership interval
Date: Mon, 13 May 2024 13:52:57 +0300
Message-ID: <20240513105257.769303-1-razor@blackwall.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running the bridge IGMP/MLD selftests on debug kernels we can get
spurious errors when setting up the IGMP/MLD exclude timeout tests
because the membership interval is just 3 seconds and the setup has 2
seconds of sleep plus various validations, the one second that is left
is not enough. Increase the membership interval from 3 to 5 seconds to
make room for the setup validation and 2 seconds of sleep.

Fixes: 34d7ecb3d4f7 ("selftests: net: bridge: update IGMP/MLD membership interval value")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Could you please validate this fixes the flakes for the netdev CI?
It fixed them for me with the CI's debug kernel config. :)

 tools/testing/selftests/net/forwarding/bridge_igmp.sh | 6 +++---
 tools/testing/selftests/net/forwarding/bridge_mld.sh  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_igmp.sh b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
index 2aa66d2a1702..e6a3e04fd83f 100755
--- a/tools/testing/selftests/net/forwarding/bridge_igmp.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_igmp.sh
@@ -478,10 +478,10 @@ v3exc_timeout_test()
 	RET=0
 	local X=("192.0.2.20" "192.0.2.30")
 
-	# GMI should be 3 seconds
+	# GMI should be 5 seconds
 	ip link set dev br0 type bridge mcast_query_interval 100 \
 					mcast_query_response_interval 100 \
-					mcast_membership_interval 300
+					mcast_membership_interval 500
 
 	v3exclude_prepare $h1 $ALL_MAC $ALL_GROUP
 	ip link set dev br0 type bridge mcast_query_interval 500 \
@@ -489,7 +489,7 @@ v3exc_timeout_test()
 					mcast_membership_interval 1500
 
 	$MZ $h1 -c 1 -b $ALL_MAC -B $ALL_GROUP -t ip "proto=2,p=$MZPKT_ALLOW2" -q
-	sleep 3
+	sleep 5
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
 			 select(.grp == \"$TEST_GROUP\" and \
diff --git a/tools/testing/selftests/net/forwarding/bridge_mld.sh b/tools/testing/selftests/net/forwarding/bridge_mld.sh
index e2b9ff773c6b..f84ab2e65754 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mld.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mld.sh
@@ -478,10 +478,10 @@ mldv2exc_timeout_test()
 	RET=0
 	local X=("2001:db8:1::20" "2001:db8:1::30")
 
-	# GMI should be 3 seconds
+	# GMI should be 5 seconds
 	ip link set dev br0 type bridge mcast_query_interval 100 \
 					mcast_query_response_interval 100 \
-					mcast_membership_interval 300
+					mcast_membership_interval 500
 
 	mldv2exclude_prepare $h1
 	ip link set dev br0 type bridge mcast_query_interval 500 \
@@ -489,7 +489,7 @@ mldv2exc_timeout_test()
 					mcast_membership_interval 1500
 
 	$MZ $h1 -c 1 $MZPKT_ALLOW2 -q
-	sleep 3
+	sleep 5
 	bridge -j -d -s mdb show dev br0 \
 		| jq -e ".[].mdb[] | \
 			 select(.grp == \"$TEST_GROUP\" and \
-- 
2.44.0

