Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891E332EBA
	for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798767; cv=none; b=VNGzAql6J3UaP4cTAg5wTUGSqrw+YxOzKgnjp/F7WIfLsNxkgIjBDQdqJ/zeKCr64a7CUyaX1sGwWjah6yVmaDPwyp21XFAkyqxnyzyHVLMbD33KBpd6GPM3OyIpzkinv3ZBDfL8AoROuLKconXyOZ+LIXWXipkeVrZ6NZXJF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798767; c=relaxed/simple;
	bh=NBybN5/snlW67CYY0LDf5z9mjlB8/ZE5MQWmfMjzEtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdibcQcfsbDqKilbIcR6UyCLWwjY31I5L6woNyyLtfEBYgSSnmJpFDabBDeGokoWfWEBTxAMbtVItBd5ECE2VALN8oW8EMDMJ1yxh0XYFjuGZ5zFTJ9mYzxA0CvdRakj2HPON6QbhklYfEjUzVZh8eugPW9vRT5Ctq0msmJLuO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZDP/Ca3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZDP/Ca3"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a09d981507so12622505ad.1
        for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 03:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798763; x=1766403563; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TrKHAwDmwEWPzZzAT0wzFml+5He+R0bXqVhPFRZE9SA=;
        b=gZDP/Ca3glUGpsOL88136XjyqTUre9tuSG0IaWiK91X181uTIHAAplu2+drvFk2qpS
         fFxc9tyusHqACh0eZsDNBLtTSQXf1C6VUSFFd1mqYLXZLBB/NXqHDhgWiId6ILjl3jF3
         aNiAoXkgP6gLJzr0oPNvlpAuwN0w5DhqrVvur2u0tuHgYO3FkOvn/YqiJFzQnYW9Lo5U
         5wIDHkTS2oI/xf/XZRw76+GBjSjLauZXS5aW1z63scgRjUqQoXkgFYPOmCtXDx7Whjym
         lBhI7sj7CFiLV803p134NQzAMk0gxeAHoRQHjJOdcSTevzkk/HK9f9H77IOjgWrxXjnA
         52Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798763; x=1766403563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TrKHAwDmwEWPzZzAT0wzFml+5He+R0bXqVhPFRZE9SA=;
        b=RcTJJa8KF6J79cr/gui79yxZwgPVjZumxDy1FIOAqnvFLHnxbvapOq8tP05S54n5tx
         kOUZtDVN/rDa8Iprq2DshMU//L0Xlk3LCcrMznMGZqbXMstjye4fBVv7suRaU/0kykGe
         amCO5ICZocfhWhPhLJ9tnG1mGPfw0CcsWBl2Ru6bM8mITd0NO9oAuiGJ1C5f8i8qq/xc
         k9MHRCyovD0SFHI0eJ6x+5PMMvFvC5Ll0k7lvuYP56R26g1Ez702FiKUeMaS5EJ6Mtp4
         JU5UJPvEu2+dgjsrJE96ePpWntil3NuB89ROCS3ff1bgRC6P1cOPBGAcxOlbec/dI2hk
         PrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5M8sMDz0vlVE5FX4atwRXZ/GVlnP4br3l0yXwiKMYGKbVx8Oc9vVmpDrvzv0O9TzHJS2nTO8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yyx/u6HURhnG29LdYzekT53FPvJZFpY1LEVZ8rjBKme81oKACKL
	2yDdGgS1BnnPcbrqd8peIaW+I41hOxJ7REBQKiAi+9FFNvcIyIFVUjT3
X-Gm-Gg: AY/fxX4Facibz4jjajzbNN20ar8HEGiG6ffDngGWGWhgbPNe3vEqVYjmE+QcvsyMDVY
	PTLQ2HjWL3Et26ny3kCO7PGF4wn5mMaq04b8hXRfOymWhPldzOCZlEzJXQXdJlGE1H3+CfqRfGo
	8Ertsn84D0Z45xnsxdhlHT+D3DCQ/US+jMyfUVV10jcbLh4HdgSgBBhMG7uKxzawQVeeghnTEXC
	GDGIku2ZmxTm2+nApM/34174zkbK0sDq3eQCInL614j9x9KhKu23YaLK8axKPAVQOHJ7JGl7Cnk
	Uzv6xwjegTbmndGFuXJ7O1iwoEehhvtLl3UQ0EhKn4FjY1hqgewdZNyu4cf0aDALFGmAMbU4pUF
	SRAk45zNUYrAjD8b/33fBF/FcAr6LmQ8f0/qZBYDqWqlqVKw3lsZqCum9SwFYJv8PCab2Fd4iX+
	zlmHzCiQB2Q3M=
X-Google-Smtp-Source: AGHT+IGEKo7pUOqZ/Msgj5pboeIPXCGG8SyTdVwEqd2zfEZHqjnoFfxwhdJcfbexnC7zJuC88ktUrA==
X-Received: by 2002:a17:903:1988:b0:2a0:d0ae:454d with SMTP id d9443c01a7336-2a0d0ae4b49mr35282785ad.22.1765798763267;
        Mon, 15 Dec 2025 03:39:23 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0f58d7c27sm27523715ad.24.2025.12.15.03.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:18 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 357B044588D8; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 11/14] drm/gem/shmem: Describe @shmem and @size parameters
Date: Mon, 15 Dec 2025 18:38:59 +0700
Message-ID: <20251215113903.46555-12-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=bagasdotme@gmail.com; h=from:subject; bh=NBybN5/snlW67CYY0LDf5z9mjlB8/ZE5MQWmfMjzEtk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4OX/nxidPxCa7t5fuOD8HMfrQSuP1hub/O7ZcKpR 3k2jWdLOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRtAcM/yunTjs9ydWYJypu wYcH6cfFNi1X5dYSuyPxxuv3me1JcpKMDBs+vU9uutHzrUbncPwy+73MjZlbOwIfHrr54bGU4uz aOwwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warnings:

WARNING: ./drivers/gpu/drm/drm_gem_shmem_helper.c:104 function parameter 'shmem' not described in 'drm_gem_shmem_init'
WARNING: ./drivers/gpu/drm/drm_gem_shmem_helper.c:104 function parameter 'size' not described in 'drm_gem_shmem_init'

Describe the parameters.

Fixes: e3f4bdaf2c5bfe ("drm/gem/shmem: Extract drm_gem_shmem_init() from drm_gem_shmem_create()")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 93b9cff89080f9..7f73900abcbb9d 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -96,7 +96,8 @@ static int __drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_shmem_obj
 /**
  * drm_gem_shmem_init - Initialize an allocated object.
  * @dev: DRM device
- * @obj: The allocated shmem GEM object.
+ * @shmem: The allocated shmem GEM object.
+ * @size: shmem GEM object size
  *
  * Returns:
  * 0 on success, or a negative error code on failure.
-- 
An old man doll... just what I always wanted! - Clara

