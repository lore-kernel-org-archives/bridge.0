Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BBF330B08
	for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798768; cv=none; b=LBIFy/pTxcNNuFD4HySLt8l+hWB8vTrnlF/mlu7ap1vUIYlECtxI0zYswlWHtxZ86rPG4i++ISJqe33U76Q569x9dN5RpmpFvZvRxLdJm4IEvsNZ9oRbeDAJq1eDO2KA8PkiRmB4mdlTYYNhZQwagL6h1XeJE642dsK6VvsH1lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798768; c=relaxed/simple;
	bh=XiWwx/yBvL5qhtur1OJ6r0Qtve5kN/UAKMQDFDv8Kk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FK0M+3qriAhkY6VXLanNe4kotdsGhz3aza36LF2vXGaMiCDZAMO2NTIv/J6dDf8UUU48HUvw5+573V3FxaEp83stzrqQ6ZI3oYG5pgogSddzRe+WGt7yOca/jdiBgxuVX0TybQwfyDsJxJPh4b9p0e8FfirAKdt6tieNvQooAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJNp39p1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJNp39p1"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c708702dfso1110373a91.1
        for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 03:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798763; x=1766403563; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFsNe5Gu995f8GfU2RxaYzwbXM91ZCVhfkD06BV90tM=;
        b=YJNp39p1Ijwc+c+eAS5dBByADdFq6WT35c+0T8SHROF2CUZHX0Hliz6COMADhVV76m
         XY6Y48oyoyJAUI9Umrh/q83G0j1L/cg93nGNlVEz0+P/dHYvtHldtQK6gr8rWcB7bZl5
         MojVXJ22gU9xuIyuVVpjlxOmojHDd9LXi85F2osCr/QYB/pIQcwwUA8xY8Aig5Z7uzDC
         u3IY0s/34f2nuazO3nx8bezD0CuUFwu3jWY2FfByc4EOzBQSYjn81iAUInp/9tOlTfEh
         U69RHirAAWDEXBhaUWI7rcpcxaZirC5l0PHgCjgGXc/vg9dRQ/alu4nrKlQ16trVjaCu
         pldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798763; x=1766403563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KFsNe5Gu995f8GfU2RxaYzwbXM91ZCVhfkD06BV90tM=;
        b=Zsm/MSJGUN2gwE/H5XEsdMhL/ewyVTsFkFJdVAGtT/9GiHTLOGsH+wMOjiZqxVRylf
         W4xCdp8bRSpmLyxjZBkcN+s4K7OwnzjtwrDupb5j4YrX/Zzl0y+P/CvZil2lxPla3Jg5
         pLgOsM+wB0Gvd4uFQ3zV4mEymP3zD5/OK6CMMgU+GO3IXO98q8JCyZQn+d+nfuGTQFdG
         yBp5Od8QCUsXBHcQnk5dtfR87APieJ32y+yTl6NvHv/pjn8DkgFHtJTZtG+shXpvMltg
         fFY9i20AztDH07sOgqJPwe/65UumF/8h6QTMwz4R5DySxBZu3IJ9xM8qSxi6cQpEUtsj
         r31g==
X-Forwarded-Encrypted: i=1; AJvYcCU7ghUV8akqCzkOjeu0K/UmoBwSHSJrZikHw2Y+MOgVzk32wjAtE11Tg8QDJUkw37/IE+zH6eY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxruKB5hUZ2tGZLMMCuHkzKy1unPnMjtpSWyqnUBQF2+Q5ryDvi
	A4nrCQwxJEI1s/GiMWObluC0cFeB0EmFZ5WUilJCtFa7pAJ/D/iSOhl3l98XT+6ZCkk=
X-Gm-Gg: AY/fxX6Jw3oDYkoRKjNvFAgfHIPx2/iR4/H7ldyFJB4nWtHu5Vi4WbDsF2C6yA7OR+G
	bFocsTep1cQiKZyq7hCtL4WGi1iVSN64jSrUQOa6YoVVTTF70TN3KCoI/EdYekZu/73CEI36cdZ
	lwG+w1WEsIr12roAzw1iwo3UuMhkK6n2rEwJikgVm571GzGdU9viEro6MkpZAbEL6MdvLgTLGu1
	rlc2FHNU2bnjinB9T24H6Ia62all3SDIanTy/mO6VpPVkhV49Ad2PGpb3RuZ51S/r/zJCMUy3HL
	ba9PBcFRlRTbWCM7U7atR/0zBPHp6roBJD4n0S7O/AGAaEY6ZDly/8h/ok4iKX2sgOWD2VTyNCU
	JmLrcFZhQXPhgULEktDfcw+N7iEESbd3y+KTx/Y69z7wRmTs2/huCCYf+vVQtkBzMOop/lWZMDa
	/uQYcAk5wPfSE=
X-Google-Smtp-Source: AGHT+IEy2tcNugFFoZ/L1b/kwWL3FdgAjYD+lvIJBPYKZMY6hs2UzwV9S1AhT0ES6IDo2vtVEhI5ug==
X-Received: by 2002:a17:90b:2811:b0:340:bb51:17eb with SMTP id 98e67ed59e1d1-34abd6d35c0mr9572904a91.15.1765798763360;
        Mon, 15 Dec 2025 03:39:23 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe2f34c7sm2908684a91.9.2025.12.15.03.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:18 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id CA7C1444B397; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 08/14] VFS: fix __start_dirop() kernel-doc warnings
Date: Mon, 15 Dec 2025 18:38:56 +0700
Message-ID: <20251215113903.46555-9-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=bagasdotme@gmail.com; h=from:subject; bh=XiWwx/yBvL5qhtur1OJ6r0Qtve5kN/UAKMQDFDv8Kk4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4O3vI8WDrMwXuvBLq8mNivp3ZeuaVYeu+cJXRZ0u 9ehPPdrRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbSG8vI8EpCRPb0s1m/77E2 hv9V7O9IOeS06tfyqjLP7/lK/+xuKjL8zzy7NtZA+f5K8VWm3d9utqf1737naLT7ZsEzs3nvY45 PYQUA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx report kernel-doc warnings:

WARNING: ./fs/namei.c:2853 function parameter 'state' not described in '__start_dirop'
WARNING: ./fs/namei.c:2853 expecting prototype for start_dirop(). Prototype was for __start_dirop() instead

Fix them up.

Fixes: ff7c4ea11a05c8 ("VFS: add start_creating_killable() and start_removing_killable()")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index bf0f66f0e9b92c..91fd3a786704e2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2836,10 +2836,11 @@ static int filename_parentat(int dfd, struct filename *name,
 }
 
 /**
- * start_dirop - begin a create or remove dirop, performing locking and lookup
+ * __start_dirop - begin a create or remove dirop, performing locking and lookup
  * @parent:       the dentry of the parent in which the operation will occur
  * @name:         a qstr holding the name within that parent
  * @lookup_flags: intent and other lookup flags.
+ * @state:        task state bitmask
  *
  * The lookup is performed and necessary locks are taken so that, on success,
  * the returned dentry can be operated on safely.
-- 
An old man doll... just what I always wanted! - Clara

