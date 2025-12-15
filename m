Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7733122B
	for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798760; cv=none; b=TUnDHMZCb+nSWNGztO5kGin5xzCsRKlPSjafOQni6SlObCgnqmPN17pLoKjd36eFSpUjvwZeq0UTa1yNRGTO2SfdVUqhgmH3+qaXvAx3/HWclOWLiu+yarpMb/J4jiJoCi5bBNHxZJ6a7elylbGDi2mn+fY6CBnFv+3fJMt2EsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798760; c=relaxed/simple;
	bh=bVwk3E00Ao0/BsL4XlONNDCfpFF0qzpzGvJu4GqJ/kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL8Xi70XqIQYbt7mJhNZzyuLUSkcbvqOaNz1b7V9XLyrGxrOL4k67c9bUQ+bHKMZuQ3QxrOjtUHcByW9PyVjzr5GqFkgem9Jp7WPjos8wDCHCDB5hw11FRK2fXhju9lvTG8x3DEchzKnyOhvmLxmvOhDdnOHkQzqI/XEs6xGvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HmJisHTo; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmJisHTo"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c71f462d2so995999a91.0
        for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 03:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798756; x=1766403556; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9thXFyBI9wECeAoZwvjVxFD8Ol9j6G4X/I1qZGpsX1M=;
        b=HmJisHToIavdOK7WGBKn45QrlGuULD6u9UNyvfxOJzu7/6t5DJDQws6pGLlsW9XfI9
         c3QD1f5dV7yye1IdtCMHLLmSrjDCxVR9WbH4tlm5qDO4XSisl9OgwWEivgey6sv+7Ody
         NmsUb6Frl3n3l7QGs6U0oGMkcpIWUxkG+RBRLDRHVI56nDR316jP93nc/Qtqd11vEKJZ
         XJVZK60GrRTJfD5R/nmVhq1u5AdEOXZ1Rmtso7Hz3Cb+I4xUVKkcYvng2X3AewSTt6L3
         tZ/wYcJ0JHNX+KDBSAuKdjmWtGz1puSVMSph+PhR9RfrkdLBzAokOHVqb/K46dld+3rS
         U+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798756; x=1766403556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9thXFyBI9wECeAoZwvjVxFD8Ol9j6G4X/I1qZGpsX1M=;
        b=A4MSDXe7jJREDEGV4PZmuu65QbchQxg8ClFcpboCHtAD3yZD1gzyTw5OOWUzAAZXz0
         wnMHt9OJdiIdbPn31KgAHbLG60zUn4TV1OqrAHzlL56UDAqgwq3BzVeCBJt8HKHYlxh2
         dikNnryTPLQwnoC/yR7wRc/GHIwyijW/wFOyAwHa5TRNzNI2pPdpxCpJ91YLQgihqkdn
         7rLiIl6VViTdyGC6etHYsvcpps15eM4BG3Tnx49+1LYK+aJDQhozF2gew+F3JNsIvqJK
         ApN1X6Fq0ms206Ttij+qsjjGOyhg7tUMLN2SJfpAYFG28j69ccma/3dOZhObipisLGML
         giFw==
X-Forwarded-Encrypted: i=1; AJvYcCWrOMzSBv+XgmkVSxrD+lCL6yKRSIccJh+YAgzkc7Ses1dwsG7qX8a8fYQIj1RDYBNLpnd0dyU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxuPSIsIfhFYg9tFwapyGODCTOeK//YuuJ13wJN8Ff0vU0kCjvr
	1hld8W51OCu7lNIXDS0rxb7bvg60/tlbSErlProFus3wAiX5ZHIP7Bsr
X-Gm-Gg: AY/fxX6MfgmV4JRnTmZyyiMm7t1fL/uDR0RmqoOOlyhSBDMt8GQnYBZ7No1ZD98LHr+
	zD3Oy2MOri8B4Q18PkK4FiLE8p56RWVq7Td254ZCdWFp/P+YIMXHJ0QQmIKHPcFmfUXXaRbaDZv
	UZCt20yZNt0WiCGA3SYDVXPGj7bvLwvjC4O4Ff6SH9lSMp+r6n+cF9ohqhiRvkKgclhd2NvUbKV
	rjf/2ho9OQ+XbBbax4DmukO46JQwoUEKblCu7RwXeoO9+heuHFezY+RtJJ/rmZfvMqWMiE1afx3
	wfE8Lnb4aHe9rDLSbXvaBo8SCjQSu8Oiiiy/9NUoGZvOBXYTaYM+utYERjgaDlwscK8FfQ+BZ1X
	bM9dpkw42/B8CmyAM+Ytms1H5AentxlJ+SdY0bbFVIoGd3vCcgPbKTOXLktlrg2xtSgByu/7ZB+
	hshiWUzC8KvM0=
X-Google-Smtp-Source: AGHT+IE3LQMlInYBtZW6kVYJLJE4CFzfJfm+/f5olU3OmDWyxxykzQlHP1rsXKl8Sxl863J3gFT+2A==
X-Received: by 2002:a17:90b:4b47:b0:33b:8ac4:1ac4 with SMTP id 98e67ed59e1d1-34abd78051dmr11974090a91.35.1765798755860;
        Mon, 15 Dec 2025 03:39:15 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe294892sm8918293a91.10.2025.12.15.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 9EFFF444B395; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 06/14] virtio: Describe @map and @vmap members in virtio_device struct
Date: Mon, 15 Dec 2025 18:38:54 +0700
Message-ID: <20251215113903.46555-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=bagasdotme@gmail.com; h=from:subject; bh=bVwk3E00Ao0/BsL4XlONNDCfpFF0qzpzGvJu4GqJ/kY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4N3qByLSAtcbrWEYbHxfzPeVTVyK4Naco81fnbf9 sGw4M+ujlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEwk4Ckjw37unJpIS7sDggaL LUJm/L7quGjlN51XE6JFNZoPynqvOsvIsMhqy5y4fbtebC8768S8lM/yytfC9QdFWExtD//Srpa 6yQYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warnings:

WARNING: ./include/linux/virtio.h:181 struct member 'map' not described in 'virtio_device'
WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described in 'virtio_device'

Describe these members.

Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/virtio.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 132a474e59140a..68ead8fda9c921 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -150,11 +150,13 @@ struct virtio_admin_cmd {
  * @id: the device type identification (used to match it with a driver).
  * @config: the configuration ops for this device.
  * @vringh_config: configuration ops for host vrings.
+ * @map: configuration ops for device's mapping buffer
  * @vqs: the list of virtqueues for this device.
  * @features: the 64 lower features supported by both driver and device.
  * @features_array: the full features space supported by both driver and
  *		    device.
  * @priv: private pointer for the driver's use.
+ * @vmap: device virtual map
  * @debugfs_dir: debugfs directory entry.
  * @debugfs_filter_features: features to be filtered set by debugfs.
  */
-- 
An old man doll... just what I always wanted! - Clara

