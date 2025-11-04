Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6680B2ED858
	for <bridge@lists.linux.dev>; Tue,  4 Nov 2025 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257805; cv=none; b=rIRDk8EHoTd2D0m7CbyBN4r2ciwcJsyAgEWQqE7Lf/t5ZH/s/6LZ1XodLkzQoa1Pcmd0vQjHRAitjQKQVRxssLRZiLAMQ8OitssoZTTjNnpgctlF3c6iFZtwRC33reHJ6Ri8aaAxy+nbGMh8NAJXtABqCuWpJGtKs7NQNNixb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257805; c=relaxed/simple;
	bh=WqQ5LOsWzxd4q/cXJqOV2o+0+/GhIJo/SZMXegXdxEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTIQ+uP2dhq6R+Fz9LJU0Ilxx4sSmZ9ndWb98RVPmsUeONt5RKccJ6ZIFqkEwOOSo5kH0VyTNIAVLUdHaUkPBBCKvJo5Y5S4g0wQyND0qxaWwxHEYAzLqUR006tSvgCGyDi/Inn0/+v4PaVb732KyKikgxmwFz5C5OvglZb/63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=W0StWPuN; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="W0StWPuN"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b70406feed3so1227128066b.3
        for <bridge@lists.linux.dev>; Tue, 04 Nov 2025 04:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1762257802; x=1762862602; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvbqWBgLxJDAhey/iacVcsdDYJtkr5fIj/Bp321hkOg=;
        b=W0StWPuN3AfL4bIuuYgpFxRMudg0Z00p84zKFXPueKNU8jldSIgkhudGQIpeSSm3MC
         E6i3TMz6GrFRaanKOJqWGmEUuBGu9Ov9PZ+k/PB91qs5NEsJpaVrP6wDBZE2V5QExwCr
         CKX/nuslwjd+SIX2/TFZGpiZIIk90/99f0EVDkuTZF4GDp6NNvhRe8nZph1p6w9KrQ2N
         T5dgkmmdnF6gnQIcdRyRaypUh2+q3Nb+5QYkcckZmkH6bARnDWPXfSbd50gQga/lvk60
         EENpoC9ZDC5cz9qDg9NQj0UVU+Lul04G1rMUc3V3F6v1TjII9Jy76gYhOs/uWs/KKC+t
         5pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257802; x=1762862602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvbqWBgLxJDAhey/iacVcsdDYJtkr5fIj/Bp321hkOg=;
        b=SR2g9h17N5U0V7QSvn4eN5WptY8dWXnZAK6TXWBihZzNrejSxybL12+UjFZesOTNpI
         TbwP+nsPSllq0zF69rjzS8L3PrmF4ihFMg6BTAORju7Gcq1NauTAM9H9qYNpCVJGlt5J
         c92vW73MrWrFF8TnAg6nQSI7z71rwJoLnOyrMQQVP6DfFcLL2WMCNtiaku5l/nFVVRx1
         0jsEROIt1db8vCtlGyFKOmud8VmlHs+1gTd0J4h4i7kNJCLrunJw2EcS8LeVI55NLMHw
         NOb9p61VXK7m78cGXkmpKWeLyI+iDMl602bBwQQCwc9LEh4NQ3E7P9gugM0wWse7H5/n
         RgyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1LZBzdFKyIhdq8H/HovQPMId0xlJhjyFzoMSBfGe8zTe5X+D71+vJuaBf3MDY4d8WkpbeejQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwVVKPi8FwVNEgTdesbQFuMfa8JQsX6gQA+rMrF0QNN0jUeOOi1
	HegzMFsPJDDXmuzAGgGWn5IDf9j1jd3Sau90z1OtHNtRQ/x2XzhX1PkYhRpnMkO9u44=
X-Gm-Gg: ASbGncvdRB1OoxaWV5VEtql9/Sj2JxJZpkgKrXGWmZ88rH3rNALb776weSVsXzExTIb
	8aUsuezxtYqfBQUvun0n5KBLOMqOQfX1Ojyrj5HWshPDYGuPiSgkIjo58x5rbK2DKPppknlNA4H
	EH7zbNsyrwew/8YfXgjS2xMS9BhQyZMKMR7+0nGONDbKWUqs50RNQy5brSpE2vLSeMOey+2AObc
	6JnXTlsB0BSJArDY8Rl+YZ0v+zSTRWZTka6GZOboaiXdhQpYvGKFw86lcSBihuY7cgO0t/4VzAj
	aDpi0UR4YlkAudsXaG8I758j10AeHoI/UnsWya2GX/AcRtzqqashkg5olQAupJpwD1akTWXYgmu
	3K9hVEL9rWb7AJV2DgELuh3UbPmVgus7/6pn4p2UqLUrBdPv36RKBUG97ccSlBcL+aqbRgGy2bx
	U+JIAvq970VPncqYSv/ooiGk7LMlxHwn4ZgQ==
X-Google-Smtp-Source: AGHT+IEeTSpLZEihOentgy2q7pULZCs4PZHYtywdpRDtbjbVTMWaGOn0tMquXEH/8nFuSuogXRleNg==
X-Received: by 2002:a17:906:7953:b0:b72:5a54:172f with SMTP id a640c23a62f3a-b725a541c89mr102075766b.53.1762257801493;
        Tue, 04 Nov 2025 04:03:21 -0800 (PST)
Received: from debil.nvidia.com (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d3a3082sm195032166b.11.2025.11.04.04.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 04:03:20 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: tobias@waldekranz.com,
	idosch@nvidia.com,
	kuba@kernel.org,
	davem@davemloft.net,
	bridge@lists.linux.dev,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net 2/2] selftests: forwarding: bridge: add a state bypass with disabled VLAN filtering test
Date: Tue,  4 Nov 2025 14:03:13 +0200
Message-ID: <20251104120313.1306566-3-razor@blackwall.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104120313.1306566-1-razor@blackwall.org>
References: <20251104120313.1306566-1-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test which checks that port state bypass cannot happen if we have
VLAN filtering disabled and MST enabled. Such bypass could lead to race
condition when deleting a port because learning may happen after its
state has been toggled to disabled while it's being deleted, leading to
a use after free.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 .../net/forwarding/bridge_vlan_unaware.sh     | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
index 2b5700b61ffa..20769793310e 100755
--- a/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_vlan_unaware.sh
@@ -1,7 +1,7 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding pvid_change"
+ALL_TESTS="ping_ipv4 ping_ipv6 learning flooding pvid_change mst_state_no_bypass"
 NUM_NETIFS=4
 source lib.sh
 
@@ -114,6 +114,39 @@ pvid_change()
 	ping_ipv6 " with bridge port $swp1 PVID deleted"
 }
 
+mst_state_no_bypass()
+{
+	local mac=de:ad:be:ef:13:37
+
+	# Test that port state isn't bypassed when MST is enabled and VLAN
+	# filtering is disabled
+	RET=0
+
+	# MST can be enabled only when there are no VLANs
+	bridge vlan del vid 1 dev $swp1
+	bridge vlan del vid 1 dev $swp2
+	bridge vlan del vid 1 dev br0 self
+
+	ip link set br0 type bridge mst_enabled 1
+	check_err $? "Could not enable MST"
+
+	bridge link set dev $swp1 state disabled
+	check_err $? "Could not set port state"
+
+	$MZ $h1 -c 1 -p 64 -a $mac -t ip -q
+
+	bridge fdb show brport $swp1 | grep -q de:ad:be:ef:13:37
+	check_fail $? "FDB entry found when it shouldn't be"
+
+	log_test "VLAN filtering disabled and MST enabled port state no bypass"
+
+	ip link set br0 type bridge mst_enabled 0
+	bridge link set dev $swp1 state forwarding
+	bridge vlan add vid 1 dev $swp1 pvid untagged
+	bridge vlan add vid 1 dev $swp2 pvid untagged
+	bridge vlan add vid 1 dev br0 self
+}
+
 trap cleanup EXIT
 
 setup_prepare
-- 
2.51.0

