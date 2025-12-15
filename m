Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE30B336EC3
	for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799327; cv=none; b=S61snnvXCrxD3mMe6bgcaqoy5zGy5f1av832s/Qe0BdruQjXj4VDw/Bw2ZJdv7r7jfdO6ob+bN1X5XgrNPayU4JIf07OemDROrWgZ2dNye7D12Vi9JRUNsx+cnUmfS/T0fBOJy98h6oXzPxMFGDr2ETbGan63T00bKvFrqryu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799327; c=relaxed/simple;
	bh=Q9RPGjCwe41o18D04IVKznpQEFsNHpWb2BdI9cEOKh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B54m8Vl7e+ZRPk1IcinMl65ZJTGyNTVQMxGu/NJB5uoYg/Pekn8hkBlHSDPveWrREKnw4fXiWnBRHjdbOeNfGcwPGUElDlBZ++2bnOnYwycEZkIDuj1rJDAb5YuNOvP1GE8twaKoRyiAoaxd5C0mJDWKn67AzOhYOF739dRTBzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSHjNPeO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSHjNPeO"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-343ea89896eso3417913a91.2
        for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 03:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765799324; x=1766404124; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E8ZSVvZ3A1H5XIeWol9WzN+P6GbKkkMDrw9AgBsXoI=;
        b=MSHjNPeOUmv0ONxcvkX28AI67swemZ58S0TFajxVH/Lu5Mrp2lRNIiwC3l7BI86gXP
         SVSvvsOPUbpkU/6eOLm6FInNwAGbC8VSWusz14IzCQV5cSjIbqjKv8ogv0YnnmMSfkXr
         XEHt+v01oCx3tca/9x5fOzy0XTXP8uSWqoQ+Zwjuld0BYaQZLVrWnIQjsZxJVKmT1Vwh
         3aJ06II/WEYl60urVvEFKq4srobk4do6F/oieB00rNH7W9kNyQzZLk+nQ5lDYnQ68iCT
         vglZ5rzpCnHvTrvLs6CwGzMcs83N+RFS8aZK2UJjFqWLxe6KzK4iXcKMWhoOwsULK0ya
         NTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765799324; x=1766404124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8E8ZSVvZ3A1H5XIeWol9WzN+P6GbKkkMDrw9AgBsXoI=;
        b=DT6i1Ztyxu4xkvZ3ftoDy324zE3dHQ8/CrFGfC9/i9ZLdRxbd9ykdr1zS84stmuEEf
         6W8TNIhrgxXANVbiWU9TUHwTkcF3eolCcN6txvsdxq1mjbCqpDGttJIQ9yBS5S2FTZJ4
         F2W/PX8eDadKsxHpH9zFKVWB39p/gn0dPeuph+hnp2x7IJ6RNo3CK7UplVvfFEAMd2s2
         uQX5sCBt5C8D5HGKLveOEnHxPYzfVTNw5xF8MwJocY0HOwjxtZXO62nseSSqOX/QPEGA
         o/jg7kkpvamH4IT0hV4mfH+hcffDaJADSFE2paE9H9ZQGviTEFrhUY0AzlpZPfxKEgjy
         irxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJW4oGgLJM0KAaDb34wINqz5lth7/V6scPo40qrHmFT3bvWjIZcmp1d8qTABZDMbgtHBHMzEI=@lists.linux.dev
X-Gm-Message-State: AOJu0YzwQwPkskOPLlXN7tDEgT11YCY61mKHQPHnsCy4jgaiyI4VSp6I
	qdcDxXeNBaQqdyEDWjtuSe2C/d9rdCKQDUx5idEedC9vKjPjE3Zetryx
X-Gm-Gg: AY/fxX4ZVM5sQhgbgCkoDGEnXb6rZzrhgaLPIitjyAQID+bk/YvRZQJRSJRaENm2HsT
	u5IHQA3y27jH9IqEBBViSBEnjU8C1tjyNTD75ROG6cSb4cdUcxmzoIWTQE+yajnAwBmyUizTPWm
	3ke8rfXw9FCNCYLlJjIOXeab7qjSCvr9Od+XrdKKY98c8m4qYB2ydZ0N7gFe6M497FT/u8Euxff
	UDLI9wxPpgSm1KFJr7nQ3Vu0UATx/Aix6gqZtl4QJLCbMfFc6wrbCbM4X/KdTiOgz4vpcndrZVV
	92XMBSjek8eQKCtQnrFS6/Cmqy0jkpJ/SkGBjbylCYyuy1DUG0zdQe7NjKfRFRiKBh8fzbgESO+
	DwLji02S2yQXMUfCr3u/L9vhFcvhDM2JqCZjuNTmlin1i3k8gVKlIprm1Z1ittbR+4zXiztnehp
	I+c4FQXs5I+fTiW93r8uL3HA==
X-Google-Smtp-Source: AGHT+IFGPLXocnh0bsYmKlmGLz0U7nywcuz+b0WgS325GJYSuSdFNXAMsV5RYXPrF9APc0Uu9mi/Dg==
X-Received: by 2002:a17:90b:2692:b0:340:54a1:d6fe with SMTP id 98e67ed59e1d1-34abd6e705bmr9983263a91.15.1765799324036;
        Mon, 15 Dec 2025 03:48:44 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2c48bf7asm12763568a12.32.2025.12.15.03.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:48:42 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 711C5447330D; Mon, 15 Dec 2025 18:39:07 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Media <linux-media@vger.kernel.org>,
	linaro-mm-sig@lists.linaro.org,
	kasan-dev@googlegroups.com,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Network Bridge <bridge@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taimur Hassan <Syed.Hassan@amd.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dillon Varone <Dillon.Varone@amd.com>,
	George Shen <george.shen@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Cruise Hung <Cruise.Hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexey Skidanov <alexey.skidanov@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Harry Yoo <harry.yoo@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	YiPeng Chai <YiPeng.Chai@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Luben Tuikov <luben.tuikov@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	Mao Zhu <zhumao001@208suo.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	George Anthony Vernon <contact@gvernon.com>
Subject: [PATCH 14/14] net: bridge: Describe @tunnel_hash member in net_bridge_vlan_group struct
Date: Mon, 15 Dec 2025 18:39:02 +0700
Message-ID: <20251215113903.46555-15-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=bagasdotme@gmail.com; h=from:subject; bh=Q9RPGjCwe41o18D04IVKznpQEFsNHpWb2BdI9cEOKh8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n0POW63OZ/vV5HO1nI0n8+fcu08SpWN+KD02YL721 ObASlnjjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExESpiR4Y+mRyzDrR2tsxn8 /5W9nMso8ZF7PQPXv0v9ETpvN1g+X8rw39Gt4w5/EGPqsSVHKrba3jn4a/bV+2uL/9ts2fkotu6 9MRMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./net/bridge/br_private.h:267 struct member 'tunnel_hash' not described in 'net_bridge_vlan_group'

Fix it by describing @tunnel_hash member.

Fixes: efa5356b0d9753 ("bridge: per vlan dst_metadata netlink support")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 net/bridge/br_private.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 7280c4e9305f36..bf441ac1c4d38a 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -247,6 +247,7 @@ struct net_bridge_vlan {
  * struct net_bridge_vlan_group
  *
  * @vlan_hash: VLAN entry rhashtable
+ * @tunnel_hash: tunnel rhashtable
  * @vlan_list: sorted VLAN entry list
  * @num_vlans: number of total VLAN entries
  * @pvid: PVID VLAN id
-- 
An old man doll... just what I always wanted! - Clara

