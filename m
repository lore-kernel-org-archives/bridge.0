Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A562C334691
	for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799322; cv=none; b=pAd1mMsaQ8ok5Vpt++yBC+HJ6nEe12bq/MrwcBg5m0QusR92LhrnpCBwrddhsS++JjgMf6CfgArf72cK+OFG30RFffVcKa7/h54rXHmH/0L5yzWrPxto/xXaRMXP3raFqM6GQFYucMNoxSieJpg4yHv+geKHe8xpmEImbE9Me0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799322; c=relaxed/simple;
	bh=kdwYayfiPuGdbX+6/rKZkI1jkonQkDY24KG3T7ZKuZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ab1egnTsgYS4Rxc2ohUJu5oruZTrQwT0Cs5V4zHbIj6UdNZ43j7G82Chb6jhH8qwSXU2VHv+PFYiVE59LUleYtQB7yJpRO//xQWEuLCyIq01VW5XWGwVPiOus5Az9Jpifp8nXza2LyJJL5Vi/bZ88qzcKVZXvCRtpzt2XSIMm3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcsCesm+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcsCesm+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso19640545ad.1
        for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 03:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765799320; x=1766404120; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUAs+7T6aM5YvKJFQXSXqoVkTtSxZtzq470O+YaXF94=;
        b=QcsCesm+rzVlM0p0NNvahMxi7sJL0lTwLnM5tpyQ9Ob0k6K7/an2mNl0Q89IiDIF9J
         WxiVqxve609KeXbnO0ZZr7FU0cfR1o298/iv5yQviaEd+akyEAVnrfZaN+hhQeYnj+NI
         hpz+DAoGr6I259gYnFFajFFhsmijX8nYC/4cbWh6nackVl1STco+9raF+iY8Rcegwp1P
         IXXGTT9hwIv26B+8+nwrD2T4WPrhmsn2S3Fj2ke5+2x5foNZRHY8dRNm+snlWoICaold
         Qth4ymoZi1euZRZlz0l1+F3bfu3bIoDrL+m0xeY4o6ideOqbUZU7KRutzDZU4BKYNLie
         VCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765799320; x=1766404120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUAs+7T6aM5YvKJFQXSXqoVkTtSxZtzq470O+YaXF94=;
        b=DW92+lFBPGaswhTvw6ko17MOrjrN5RrKssWK4oYEDyrbpjlayNPmB67yOnM2CiTxlo
         Znb71Pulr+Dx98+PM8xiQ3X124xM9gqGv9tJeVOy5SZaDtxUTMY80Q3UzXMCrLTv/OgD
         YdJ8TgB4tP6vPu6n6fkN9S1s0SmabeLFMnlZuPkzTLAofqVZcFMNxD9PVl4SD75kuZMV
         upGJcg8Lybx94rEynkPujjRm3I/wa1xZkMiU44S4kb/CyUE5gIfjKCyEuHFEieoJPmoo
         X/eLaEdSY4DOgaN8sQm7C2Ry6pVjBw22bHbmCARijFNULLWmh7IlNJWTLXmdBqgSx+Hv
         9kaw==
X-Forwarded-Encrypted: i=1; AJvYcCWUjbbInCvnOOalcuqqGUCyPFpRxzzEFUxHGwDgYQXLL/2D+u2XahhQmqM72JB6/UalWg0HTMQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YyZwCYJ5J7P5Zmp23rrY68uojP83a37Hlo1KdPTpapAptdYbHoP
	VkXPodslChGxDveQoWJGsFujpaptq1WbDkb/CLOmwSQT9DYiJWQS/Ge0
X-Gm-Gg: AY/fxX5Ar9fQE1DCkNOz+IRN6DEhEcDVdJZ5T9K/fL9mPZTnLTUXzmn1BnPbdg/pJP5
	BoMM+rLKwpNfeYAC6U0e+Ghn+iMJOdMruiw+RCbwK3XX08oRMedybm+Vt/0f+YE5dwShDyK3uk3
	VCydbyO7V5wfci0xOI/j4ljIs3qVqwHp4ATwyQ964IUVzy73J0PstELvAfWiQszpEggDf2ZCNEG
	jvKmz9f+ZbX0nOrjljlm0o0eSktcjgCqtD+mnXqx53emzLWf+xKOp8yZAc5QdJfvkER7RuZKrwZ
	t4BwR/q33HVhoXsdyZcSOTPPt4Q+iT232ENG+UT/4Rne/lbJFU4o3JawsTJvMODh5EERQrnxAhs
	+gZoNU25DZOg3S077gMYrjbw0Ayp5MP5tU2dSk+yBm+qXsicWCdkQPVZIvyNjILPWkHwIQBhMhv
	T1XPMT0TrtU2w=
X-Google-Smtp-Source: AGHT+IEA4ldqjntSU1IZe10aX19mQKLjoCVDqCMnCNeqo44SOanRLtLHyqhQX8MxC8RVHbAWKM2xrg==
X-Received: by 2002:a17:903:1a2e:b0:2a0:b02b:2105 with SMTP id d9443c01a7336-2a0b02b228amr63659225ad.56.1765799319837;
        Mon, 15 Dec 2025 03:48:39 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a0867ebe9dsm77190525ad.40.2025.12.15.03.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:48:39 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 46E2D447330A; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 12/14] drm/scheduler: Describe @result in drm_sched_job_done()
Date: Mon, 15 Dec 2025 18:39:00 +0700
Message-ID: <20251215113903.46555-13-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=bagasdotme@gmail.com; h=from:subject; bh=kdwYayfiPuGdbX+6/rKZkI1jkonQkDY24KG3T7ZKuZA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4Pfzvv2aMJ6/2fiW3RmVPTpTFSM/fBW4Nu0ikdP3 J/+EMyq6ShlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBENP8y/FN2WnBW9dYhDc+y QzUe+4R7v/wRO/L/c0NDkJC4klf71CqG3yyrLnq/ur5px+nadXME75rW9sxVOp7eMOmL58xwZZ6 TlnwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./drivers/gpu/drm/scheduler/sched_main.c:367 function parameter 'result' not described in 'drm_sched_job_done'

Describe @result parameter to fix it.

Fixes: 539f9ee4b52a8b ("drm/scheduler: properly forward fence errors")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 1d4f1b822e7b76..4f844087fd48eb 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -361,6 +361,7 @@ static void drm_sched_run_free_queue(struct drm_gpu_scheduler *sched)
 /**
  * drm_sched_job_done - complete a job
  * @s_job: pointer to the job which is done
+ * @result: job result
  *
  * Finish the job's fence and resubmit the work items.
  */
-- 
An old man doll... just what I always wanted! - Clara

