Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B402D3264F4
	for <bridge@lists.linux.dev>; Sat, 12 Sep 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789221039; cv=none; b=d0WCGNGg8724VCoqt5iEqvw1jkGo9ywmQkTTX0wu8zCbeCgky+xA5ryW1Bv9HrWrlsfRH+xlZaVRafpANrTrJwqsDEVsYG3Ch7/hvk69JwJ4yN88bbsCnqop8b4vJPSg4SbsXxw9zdn1GpryKshlhBa5wETZJ79lRa2Vtpr/MLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789221039; c=relaxed/simple;
	bh=+1wQZPTinDQ05m6tnd+jN0uZ71x8nm6FHFC7WAcjCJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KoBahWmmYfd4MVUqzd9pzmvin9RIDnzJ8+vbSkZ25r96KnbhMp9sUKdsGsyvpdtwS6eSHirM7N0horQya4D45SyuKrhnr4C6TA9tEt07mS/Y0K3xgxekkVmN1I9xbNlOaAXjc5G1hcj3lVRkMh9YE+5q4QSlaq3KLWCr1z6NYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2Aea3Mz; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2Aea3Mz"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b79784a6edso538836e87.1
        for <bridge@lists.linux.dev>; Sat, 12 Sep 2026 06:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789221036; x=1789825836; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1JB/LtmISFBIMSogMI8anZ1fGKk9xgkHd5HRwwP3L2A=;
        b=k2Aea3MzHehp5SGSW4C52VpESWyEBm/uGlY9UjSNciyQsjAD5YsqNMQNF8jmDtjZSz
         0Xx9QThMvU47oMh2gJbdVGxHuDJx6EZ9vcWdF7yIDa6pV8A69PDnajpgyQFh4Oe5ifZ7
         QPYmZFt4izJZ7HgkOa+neeMaQ3upUU/IqQIc4EPJXSqGRqFzxbN0PinTjWfxQvTCz9tr
         oUfln5ncyHKpgogy+sQoQKq5nnmmQzccSNsnXvzFLKFHjN2b7GCnu4a4gVJESV1kxdeD
         KhMeZ5JSuCG6kUhCtstrFJRIXDgXk4jijwf0e70addD2SjatkhBgsigaTpvEHzGtk/d1
         47sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789221036; x=1789825836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1JB/LtmISFBIMSogMI8anZ1fGKk9xgkHd5HRwwP3L2A=;
        b=UElDz0vx5sy6CmnK5YGVJ/b1rESxTYBajk+hL9JwScifW9AYOLvecfF69hcIr+c5xQ
         k6btNFJRrgyam9SsPOrHb8Ovv/wJSuJqvJZiEq1FLcuSPTaSTqvU4N9cONGRda2lWghy
         90vsJCEmubv6y/2F0D5XP51VqW/uuLfVHdT8qiZkNKqlDx+MaKMRflL3XLcoqpQUaqM7
         EWLuD0zoCNgGo1kgI+u6GrHMhZhXpY5QJu0dVzGkQrI/lhdob+R2TUMF4JkOSMJShIG1
         495/0jMYv9Sa4YjA5uGG5AnA9ej2SKxre/nNPCzKgyjy5NfKR3uRx9a9BMtXElHgSRN1
         UXHA==
X-Gm-Message-State: AFuF++mW5WeE70iIZBG2dwjx0avZ+6fuwUYRbPdP9vkkd+jtuCpBO8VJ
	o4vw8ZqnPj5BbjRn8EwYMtMKAEWlSHLQGCjOSUXdaWBVepoOSqls59wv
X-Gm-Gg: AYBFou1geqnCcFtCIHadKm9BZUVB0eZmEG9OZvsc61+SgIOeDcm7s0ULUSGo2/FoctQ
	Oi+zztVM64WY1wvom93xPOW6ZIbzuKQpgRzrEqOv1a2W1LgVmlAGOjJDz7KtJVkfl4011AMvKvU
	3g/684hGZuSqnpWMPhZwFIHtcP41u5j6XiX1oMDvR6acIJNIjws3NLUmdcNUkfhqwaYvjeKo2hM
	+ZB3sTRvW6p97ARjFadbQt6wkbtgADrIPlklnt5CZqQF/YJz17Wh8rBgzmEnImFpfiaUyM6G218
	nqYs+gN7pVmUODgyuebbfSHnXOQ2HFlGBtvMYHcRvS+I3HVFzRVRljgyPNqJnAkE1xkLYhS2713
	qKj6FEHfpxrvU1THDh29W61vE4yX0wlnzY+BhzISnjBHRMYpQ3+zOOCj+urZaGlFqvdCbeTVSOi
	suHvuIsz0/jD9gU7oppn9pTrRgY6eSqPEMprXVgXTApDZ8JOtiqLHUNlGxLVDHxcnjtq6/f9Twg
	M8tT9h4CxlcpEoRIZBk1mrIeMbwhiery8++5W9VEYs11clRsMsfkUJKMnkv/uNoyipZ
X-Received: by 2002:a05:6512:3e24:b0:5b2:e947:b3de with SMTP id 2adb3069b0e04-5b8a8ebe72emr404733e87.7.1789221035331;
        Sat, 12 Sep 2026 06:50:35 -0700 (PDT)
Received: from localhost.localdomain (46-138-187-224.dynamic.spd-mgts.ru. [46.138.187.224])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8a0457246sm1257770e87.23.2026.09.12.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:50:34 -0700 (PDT)
From: Artem Lytkin <iprintercanon@gmail.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux.dev,
	razor@blackwall.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	kuniyu@google.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	oss-drivers@corigine.com,
	wintera@linux.ibm.com,
	aswin@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH net-next v2 0/2] bridge: report an oversized IFLA_AF_SPEC nest instead of truncating
Date: Sat, 12 Sep 2026 16:50:20 +0300
Message-ID: <20260912135022.1701-1-iprintercanon@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1 clamped the VLAN lists to keep the nest under the u16 nla_len.
Nikolay asked for an explicit error for both RTM_GETLINK and
notifications, with the extack set by the bridge itself. So patch 1
plumbs extack through ndo_bridge_getlink() and patch 2 returns -E2BIG
and points userspace at RTM_GETVLAN.

v1: https://lore.kernel.org/netdev/20260906224246.21719-1-iprintercanon@gmail.com/


Artem Lytkin (2):
  rtnetlink: pass extack to ndo_bridge_getlink()
  net: bridge: fail link info that does not fit the IFLA_AF_SPEC nest

 drivers/net/ethernet/broadcom/bnxt/bnxt.c      |  4 ++--
 drivers/net/ethernet/emulex/benet/be_main.c    |  4 ++--
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  6 ++++--
 drivers/net/ethernet/intel/ice/ice_main.c      |  6 ++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  5 +++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c  |  4 ++--
 .../ethernet/netronome/nfp/nfp_net_common.c    |  4 ++--
 drivers/s390/net/qeth_l2_main.c                |  4 ++--
 include/linux/netdevice.h                      |  5 +++--
 include/linux/rtnetlink.h                      |  3 ++-
 net/bridge/br_netlink.c                        | 16 ++++++++++++----
 net/bridge/br_private.h                        |  2 +-
 net/core/rtnetlink.c                           | 18 +++++++++++-------
 13 files changed, 50 insertions(+), 31 deletions(-)


base-commit: 879e280b8486d4612ad1aa050d6fada2dd80cf1c
-- 
2.43.0

