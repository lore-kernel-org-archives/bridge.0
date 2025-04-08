Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FFD1E5216
	for <bridge@lists.linux.dev>; Tue,  8 Apr 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122451; cv=none; b=PSYAN7q8qhMl128EHIUXJWb71N7a/yYWf78aqeywbao87hN+TKcAYbYB9cSAsNJLof8IHUncvlrzigFCW2kvN9lrNARaVOe55uGlfZsblmeIVQROqsWrXj9xNINmAbt712iJEfkxxIMuu4aneFT/hX5t1SQus9XbpE3toAk/v9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122451; c=relaxed/simple;
	bh=skNX0VMpyq4TImbnITCqWtOmd+XstuAPKR34qrWn8TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CNMpqjXmUndgAmE2At7EpxZRSzQReHzwLB6VnqhOD38pZON4xB/2B/lDCWTabF7aBSL2heeTMX/HiMbV7ssgyQnAXAZkb7wH4T7uXg+WkQrZx6aIpnTjAS36fo64AZmUiMwwuDwlrsD0WV7VK+WQmaliJHlGRQq5um5wQ1qcbOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g9uT+cQV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9uT+cQV"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac25d2b2354so1035977066b.1
        for <bridge@lists.linux.dev>; Tue, 08 Apr 2025 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744122448; x=1744727248; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VUm9gQnvGQXKP6784F7H7/avPA/P9IgZ4HfULi58AjM=;
        b=g9uT+cQVGteqvkoflbTaWnd7AK7xpoZ5IzdpwFE0maJGA5yT/Y5OAERzKxZq1dwavP
         8pn/9YkLklXWUd0WsJVBdFP4M0MZWElB5yJ7k8Ge5SYogZZYIvxtbypwizB70XFdUlfO
         skAbXp1yVYwXk4+WXuKRCbmopbal77X6nPxhx/Nm9doz/dXnOSXl3N1tC2pp/hCCqqwA
         t4Hs4gPLDLMHfRje9kFOEp+6T3UgvJxtxCg1W18H5Di2anZcOGs17za83Y2nmXRFm22y
         csYszmAyOxrDL3/fskvWU365zEAgStToNY+rv1QcWRcetf/hCRD4rgFOpaaWmQ4cieTW
         Ip/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122448; x=1744727248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUm9gQnvGQXKP6784F7H7/avPA/P9IgZ4HfULi58AjM=;
        b=YZWhQll0pfh3rab4RqqNfIZMSdNmERYeL2AzMK43HGmqJla626LH7D1xU+e3fpKZ2/
         S4W/i5uC+3KOLLRFeme41Drc5TDCT5Kmc6XEgS2CEzoTsv14ZE6wh3z3ruSp1qW9dlFC
         EgJbi5pGQUxe8bnFNnggfww65NdwRG3XmzM2FfALTGf3eMaNwMvnCpdJdznbfemsUx+d
         55UqrzE/xS1GU/6A8Uk9dCNBmODeS6XwdZKIrDa6+cYvs5nBkpkn3+yvSxMPshAH96o+
         ftuXogLTrcGYX3ieLjBpMwExRi7KP+Q0CiGup/zzJQKTBYyxE0d9sKKkOuq01/OU+6Al
         qUng==
X-Forwarded-Encrypted: i=1; AJvYcCWikBSKpY0GNY/PLucyPiIrsloYfACh6BXqY+2++d1vouuQLbpTCfps145Tbr3dn76y9GTNcnM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxzFp5AkGL8YGlGLUL00+ZsczLPlSdu4zqJhWkBqAO1sr4RRse9
	9L/iocclnhLBTWEb7hV9DLHdtD5fwrffkUltIVhNRLj379aC07dT
X-Gm-Gg: ASbGncsneEFoE6Ff7/wNh/Pp3W8LU75kJtZDcpXzfxFyqMTk3EoT/Wh6/X6Qzs57kQE
	NiA/mVChiVEdtcAinB9KC5w5w8B6UK3ao13Qv8x4wfRQMzKk1jcRt0/kAwMOs2Y6vSXcOz4yjsQ
	c4cwW4HndBXjellCZnYTZK3j9yg4YpBtdMrEoVEP5QFQqY4dn7vrZYaDKl9jtcQ2qzeXTtrjDzo
	VSfW2KLB6Tc2fRzuT3QyKAsRSc3xdmY1XnQRAuOS3wWzQ4VTFMiIoalcCAEXrcf1IXX66azd36U
	yT5PArrR9pnfqIGXDJLyJsMGiTM7Ydc2N78ZI/nbk18aeKKE+ObhVZ0TTGC7BrjOl6cITsDV9WP
	IPbBdik+AkypJ7R08pMnpKnBV2XenI5DpvKAPcsKSZuL3qrTLNcLkBaWE+ZrmmNs=
X-Google-Smtp-Source: AGHT+IEp5c94V6eqD35x0nSO2wKRP1MNbXvTRnXfeguOXryVg+FDsmDVzBaz9Z5e3HCToWicMtFIDA==
X-Received: by 2002:a17:906:7310:b0:ac7:1350:e878 with SMTP id a640c23a62f3a-ac7d6e05c0bmr1509858666b.46.1744122448151;
        Tue, 08 Apr 2025 07:27:28 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe9be67sm910393266b.46.2025.04.08.07.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:27:27 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v11 nf-next 0/3] netfilter: fastpath fixes
Date: Tue,  8 Apr 2025 16:27:13 +0200
Message-ID: <20250408142716.95855-1-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several fixes for the existing software forward-fastpath code, also
needed for the software bridge-fastpath.

DEV_PATH_BR_VLAN_UNTAG_HW should not be applied to dsa foreign ports.

Also DEV_PATH_MTK_WDMA needs to be introduced to nft_dev_path_info().

Introduce DEV_PATH_BR_VLAN_KEEP_HW.

Changes in v11, results of testing with bridge_fastpath.sh:
- Dropped "No ingress_vlan forward info for dsa user port" patch.
- Added Introduce DEV_PATH_BR_VLAN_KEEP_HW, which changed from
   applying only in the bridge-fastpath to all fastpaths. Added
   a better explanation to the description.

v10 split from patch-set: bridge-fastpath and related improvements v9

Eric Woudstra (3):
  netfilter: nft_flow_offload: Add DEV_PATH_MTK_WDMA to
    nft_dev_path_info()
  bridge: No DEV_PATH_BR_VLAN_UNTAG_HW for dsa foreign
  bridge: Introduce DEV_PATH_BR_VLAN_KEEP_HW

 include/linux/netdevice.h        |  1 +
 include/net/switchdev.h          |  1 +
 net/bridge/br_device.c           |  1 +
 net/bridge/br_private.h          | 10 ++++++++++
 net/bridge/br_switchdev.c        | 15 +++++++++++++++
 net/bridge/br_vlan.c             | 23 ++++++++++++++++-------
 net/netfilter/nft_flow_offload.c |  8 ++++++++
 net/switchdev/switchdev.c        |  2 +-
 8 files changed, 53 insertions(+), 8 deletions(-)

-- 
2.47.1

