Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0783C2E65D
	for <bridge@lists.linux.dev>; Thu, 18 Dec 2025 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037984; cv=none; b=s7/0LjF3l+gASXMBUhWfge2GzrHsvtl35A644SJI8ONtEzPsd9uA4EvwkLS7p5ysYKTVhM9kNrwr8Dya9gsHc3hE9AYH3Bvbe7/VJ70Lk7u+LdiDhmfsFl93OJGIUPTsWStz2HRG7iavMRdEPkGz5thslRn3WkcBC7Od62aARJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037984; c=relaxed/simple;
	bh=9pG1kIWkXMjIVH6mjO8VQg8g7XNDxmEr7Vd5Kye1VSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNOSoeapBJafMWEKLhEIB75bmsWbD7KB6g/T1PvA7Zty2vwVVjKqZHWZ7c1DR+Ik31SCCeYs1AdOo5DRZBZMByGECaYou8VSNuFLLjYoHBRi8o0fS/Djob1dNMBPRxxZL5rKPvk4z+5uXsTat0psvSvWlXty3ciNC81C42lq0is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcnZh/nd; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcnZh/nd"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso3930696d6.0
        for <bridge@lists.linux.dev>; Wed, 17 Dec 2025 22:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766037982; x=1766642782; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zGRJ7a3IeqzAigwVIl1G2eWAbLLevGhMz6Z9M3NSQXo=;
        b=AcnZh/ndSjEghjtYZmxklMm4uOEdCecaVZC4snq5pjJBDIVm3yS7XbcwY3NQJSehWm
         x9aT0R+p2lUYYzpHxaY1d/UwkVVdsHxbN5joLrgaEFf15woDrQzY6jirhUve1juMVsFj
         dRGpGgqvuDZQjeb0Lq0Ttybw/YG1qjf9DbRd5HZsHDOh11Ma87r9ixU/TNwJf4zoFHxO
         pon7NAIRjUTmNdEuQoF0ZqNoJ4dvsTAAQEfjlyhQL1PCP8CTANlX40oS1S+Ya2XLlUTF
         qBGb92iLOI7iV5c2AfLhMInib/iNTPIYlh1pPv+vk0Z2KUOy1yGSoxEPiSRUY8gleOXE
         yfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766037982; x=1766642782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGRJ7a3IeqzAigwVIl1G2eWAbLLevGhMz6Z9M3NSQXo=;
        b=AX7oC+Nb/j3UUcTcjCQ/bY01GFTL7NS3S4W7ujWOuFCqVOMhTiGNxGBvJ6vwm20n41
         9hf0RHUH2N+9o8XRNtilwEkvzLQnatAQioxdFZK+eAkMEq7WdccEBCUTjmyTkEuklvPH
         e14MqyJ4NZlXFOf4ckXgA7DflPdPk7eDWAYYunqBjoAxAJfYCPo7q7s6MqZku4001In0
         DjAkoq6YtzXjIbC01in60dnpeSUdCArdoS9fmsJZji9FagCYoPeWFAN/N71ASoevJNjS
         PK77iPDVF27QMBU2ImmKsrQ1AtyXYK3g8dLoUygKkfQqMFvTd3wluIKtvAX8LUcQXQr+
         sVQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkL4q5NBn6AcT90uPZR90fTFnOy7308lNhvQVYh3OGc/OOcHaYRdfd6f7m2/WSMHkiMCsUqoE=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywn+pzM+AIH1A2+E/yOzVkV6DzBDtFcsJhuSYgopTa+YZK4f92Y
	3nGs0OPC/tU1hp4M48yJY+g9nsd6xtHdL8VWqftqkvBK1nauNr4aeLiQhjlrshiI
X-Gm-Gg: AY/fxX7Z8Kfa5J4utHf05Ip1AidKEv963W9doYxZ5PefRcGt4NPWEdb+5L/JVnshl9D
	Vpkur1eP9weeWM6IhgMIh/DPTHZzgw0/LGPSM1wX3M+v7DGTWXbPp3Pb5U5BVUc1Wq4C+WMFcLF
	Lb7VfsE7G6IyJoKYQhksE0ZM4pQvlsxLJzBcNXssqzqoQg6NPj4gfKGXTMjcdQjBpZT9XgilKz+
	XP4hYhP4uSQOck2VQLNuL+RRbaBhmmH0GySXUacAaV4P6KxiaDom9V6D0jdPiGe3ADs6QsPfBJZ
	S3pxDuMKfhFoSkYttRgTMT1o0ZfaFnEVU1BOMzvdY/JMJTtPNYPe+dBAe29Vxs9BBpIGWKkW3On
	ru4DkKJvXkPtDolqMp4eOLhlx8ngSrLGnPxq4u6WAkT/SRBjHiD6MDL/tIYZA2sMM3ywIG77oTL
	x2b/qQXPHYJ6HfDe12b5dGQA==
X-Google-Smtp-Source: AGHT+IGYIHAW3nPGzo47m27bNrScNDFBaV1o6DunxcTyMRjHDlriB/Dh3QvCKFippaVaxsDF28jRkw==
X-Received: by 2002:a05:6a00:a210:b0:7ab:2c18:34eb with SMTP id d2e1a72fcca58-7fe0c0fd913mr1584640b3a.12.1766032197769;
        Wed, 17 Dec 2025 20:29:57 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fe12128ea4sm1046399b3a.27.2025.12.17.20.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 20:29:57 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id D032B425580F; Thu, 18 Dec 2025 11:29:54 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	bridge@lists.linux.dev
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net v2] net: bridge: Describe @tunnel_hash member in net_bridge_vlan_group struct
Date: Thu, 18 Dec 2025 11:29:37 +0700
Message-ID: <20251218042936.24175-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1292; i=bagasdotme@gmail.com; h=from:subject; bh=9pG1kIWkXMjIVH6mjO8VQg8g7XNDxmEr7Vd5Kye1VSU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJnOTauvrPurdnCSTmmGW9P5D7xt2xbHzzrMH7dfePeGH dOe92z50VHKwiDGxSArpsgyKZGv6fQuI5EL7WsdYeawMoEMYeDiFICJ3HZiZNih6pi/QO23ClO1 6pFNBlVaZq9ZZn5Kenz4X8+RrOObV8czMux3Lv03tbD0WwSnamH6hJcMlekytR37DE4LyWTXPlY 25wQA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./net/bridge/br_private.h:267 struct member 'tunnel_hash' not described in 'net_bridge_vlan_group'

Fix it by describing @tunnel_hash member.

Fixes: efa5356b0d9753 ("bridge: per vlan dst_metadata netlink support")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
This patch is split from assorted kernel-doc fixes series [1].

Changes since v1 [2]:

  - Apply wording suggestion (Ido)

[1]: https://lore.kernel.org/netdev/20251215113903.46555-1-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/netdev/20251215113903.46555-15-bagasdotme@gmail.com/

 net/bridge/br_private.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 7280c4e9305f36..b9b2981c484149 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -247,6 +247,7 @@ struct net_bridge_vlan {
  * struct net_bridge_vlan_group
  *
  * @vlan_hash: VLAN entry rhashtable
+ * @tunnel_hash: Hash table to map from tunnel key ID (e.g. VXLAN VNI) to VLAN
  * @vlan_list: sorted VLAN entry list
  * @num_vlans: number of total VLAN entries
  * @pvid: PVID VLAN id

base-commit: 885bebac9909994050bbbeed0829c727e42bd1b7
-- 
An old man doll... just what I always wanted! - Clara

