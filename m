Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA283328B67
	for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 11:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798766; cv=none; b=DyS+6c4X5ysXFW3EbAKu74UQ5GoY3NLBbgW3gQu0XV2bUmGwi60lccWBRdzfnXwFMQ64y/5W5Uu9KjQkHOqolIDmSbSFxzeOfN7hqGWUvcvCQ64i5Gk8pXfK9kgQFiTtjrS9ROJ3TYuKzkbI3MJOw7q5UJI7oJy5G11R7UJInCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798766; c=relaxed/simple;
	bh=g0JdaQypaND4lTcW0ZqbYUYcFFa4BCtHp67rCXQ3qdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVk82lBe/kvO/b+q9FSWZeydiBkLdcVXc2DWC/MdPv1rJFMxYemZ8B0fZntDpjlCbzVN5UTKdHJE0dRtx6ADh0z9Zy0UCnIJGvN6GYbck8EYqecSZf1dRk1alu3hbI6iJTNYeX7YRX/yVYS3jP3U3Eh7mCrMDDOJkaVdLBTred4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7+6IGD2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7+6IGD2"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-34c868b197eso920362a91.2
        for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 03:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798763; x=1766403563; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1jHunOtVkIwedmQvRsrzJgL7loZmMhygmTOE5iX6PY=;
        b=N7+6IGD2vBFaG/NVGjn1i0HT8JH6isiUT4LD8oaat/u5X8i66aektAJM6r0rNe3vVt
         iwKumKIGaq2pbYEbPp1s90kxUjoJmksfhWNwtvTC8pbXCJYvF6BZtDQKmy8J3tcn+gdY
         f6TxXUOSY0nElA7URA0KjfvciYbhQjkQ1XCA7t+B7gQLGs7ZjX+kYmcihCHRuPCp1X3W
         Lp95oaMOqok7D2tgtp8koew96Q3ujS+P2+cpen8PjJgGWEBb7Hv36zg8va2jgbW0R8z3
         xAlUaRlBG/Xz4MyC2db/BpVzWyevk0x95npdvSoEpuJC+2SVYoDNTnmw1JiCCGCO7P21
         XFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798763; x=1766403563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c1jHunOtVkIwedmQvRsrzJgL7loZmMhygmTOE5iX6PY=;
        b=ttL00hcKjhZFZmDZwgTV/aJqeIhg6frYeqHYs6OaG0MJpPDaCnGm5v8UVE1XBZ05o1
         NGe9G4GmBrlvZ8jzyyO30WDK6AQI714Nm0NSS1J0qfa2OcKxJ2d7c0vm0rUlqSc6wt9z
         /hvgRhClwrXLHlBDWH0F1dqbh7I5nSJdXqAkZ8P/rtT6CHJtpo+8x1paMdO4J1pRxd9z
         RCOmLeTRqUze/IaVwiLQa9iFnlkB7THzATtxIOkcRLzG0OXHvyO5AiM93ScNgLUEqmJT
         P7g9MU6NBaCxYgMMyNIPVL6B4NDpSEq1q3Ov0QPSmyI9UapHBkR8RJ3cT9LTurMGvYOp
         NQwQ==
X-Forwarded-Encrypted: i=1; AJvYcCViUdJNZOT503/HCmilmPBoZA2yIby/oWYo6CsU5oYkrfwiftoL1KcsUsOwMHxZ9Qic8S2o51o=@lists.linux.dev
X-Gm-Message-State: AOJu0YwQXHy869QFt26j1xXqn7tAXLqGSqQOfJS2E7VxgJtOkaSR7V1p
	1wsLFRo6xq0LhcLUgf09MEsHJLCmopLBY5yzpAVMv7Mn0Ye6c2YlU8eY
X-Gm-Gg: AY/fxX7NNjjc7NRdxWFwxEscItvaoBfCC1y0M02KtgAXc11XKsvQfy1srR/NnpdEm3d
	Z2M5eGMBd9IoZr4TEzWSndUE5/WyhdVSLkjtEd6jpcmoLHekf+27RPsFUeQLL1ZimN6gRfd+0fi
	/fFHo9zu+kUDaB4hAZXfy7od2nD2Hf7+P0NVvOA84GsgbzFsYwvdj56tqz3PtcxSnIN+qZoyxpN
	FxsU4PuLwmiPr8tH05FpPProBYMKDNdYwEb+t9U4b210OS6/t0Hh19CLiV3ktpvKFksS88XfNhG
	MBzE4Amio7M39CfQNYaqsRYlKDeCJUeBZ7PGHOoAwY/i0GW37F8XVg+KA3bEtG0FRm6SjAuekov
	fsmvEePK3JQObSPvIHfGgDEpA/oFWf4F3UdDOckt9k+ss7MGfR3VBKzEcvWbKGh4yLpQ1utrCv5
	UJuG0ehQP0VMU=
X-Google-Smtp-Source: AGHT+IGkBlvtTJJI36YenJR2Mj5A83uVH+1orPi0BLwAvata7acR5hue/qogcd9VSy03MC0if9MWYQ==
X-Received: by 2002:a17:902:dad1:b0:2a0:b066:3f55 with SMTP id d9443c01a7336-2a0b06646d5mr58199625ad.10.1765798762558;
        Mon, 15 Dec 2025 03:39:22 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d394easm129684215ad.25.2025.12.15.03.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:18 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id DE7F144588D6; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 09/14] drm/amd/display: Don't use kernel-doc comment in dc_register_software_state struct
Date: Mon, 15 Dec 2025 18:38:57 +0700
Message-ID: <20251215113903.46555-10-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1238; i=bagasdotme@gmail.com; h=from:subject; bh=g0JdaQypaND4lTcW0ZqbYUYcFFa4BCtHp67rCXQ3qdI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4OZ3cRMgut038Q1Mvx+WnR34qt26aRSjxQZU2vjg 6FirXs7SlkYxLgYZMUUWSYl8jWd3mUkcqF9rSPMHFYmkCEMXJwCMJFN+xkZVrl1e0394/7u+RLu +RrXLfO4ZDZ3GN7cIROa8FQ8sjv1CCPD78WiQS1yNZrTC6Ti9OZz7YjK/sxnP51XNFzRTCM96w0 nAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:2796 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
 * Software state variables used to program register fields across the display pipeline

Don't use kernel-doc comment syntax to fix it.

Fixes: b0ff344fe70cd2 ("drm/amd/display: Add interface to capture expected HW state from SW state")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 29edfa51ea2cc0..0a9758a042586f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2793,7 +2793,7 @@ void dc_get_underflow_debug_data_for_otg(struct dc *dc, int primary_otg_inst, st
 
 void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst, struct power_features *out_data);
 
-/**
+/*
  * Software state variables used to program register fields across the display pipeline
  */
 struct dc_register_software_state {
-- 
An old man doll... just what I always wanted! - Clara

