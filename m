Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D6330B34
	for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798757; cv=none; b=Tx2FQGb+5Q4o4jDOCQA7dVZnudGSANLPa6jCadrNrvSLAQhL9mLK6NCEgBrKO6uQZH8x4oGjU1r17F2MC5moOyDggoxFxKnFwpHaGVwJGlXkZA5nLFhtV2mj0Wm/bt/KJKCtrs7rEW3fUqjeexTC+2LToVHZQ7Bn3Dyv/s70/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798757; c=relaxed/simple;
	bh=sT1prVB7LRNvf/W4XodTbc9bjm2B3700BxVWkrXUues=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAkqymz+uqsS1W70FyuyhSJ8LzmnoHNOEeuehjuvDiziT7LsZanRoPswCyHLYVKrmWCnEx5987mJm/vGOXoi87DVFmr1DZHxO3Ai/oSWD7r+R3Puh++ifpHHnWM02WEoPKOdUip3NwTULtCKZX/X0gvtegZM6nlJBh5OSnAE3ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOVr9z+D; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOVr9z+D"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b7828bf7bcso3579501b3a.2
        for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 03:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798754; x=1766403554; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYIA++CxPIcYPKgHl3oGianXtJJpe/hDcX33067gP64=;
        b=mOVr9z+D5wWQVWK/7MroT/Zk1316UNy+HkMlvC3xpzyMOH8FjcXMF+BacINLcdZcdS
         7V3wc685fhMabJIuJ8sEwaNUZRx+uJMAQn7yHQ8WHf+NVbvEBpxSK1TkudsJh+G4G8pj
         x19DKTE5ypeJ3T+PEGC2kq5X1hfr5Ci2W5kvqNxrev8HYNUghoQFM+Eia0FwI37lk0Q0
         wjQdNCi/MEe3AWoumq1ReDlg9xCEkVO7cltlJKcVy+09PDCqWgYapimGQp5xDOp+8Ltf
         6lpxy3YqeaCEY8ID6MX+/XUv6Bc/H4vK5yiuM6nx36j7pcJ8BxCrOIZDkrBl9Zf9JmAY
         3uYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798754; x=1766403554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yYIA++CxPIcYPKgHl3oGianXtJJpe/hDcX33067gP64=;
        b=UGWc1Zu60kP3nezmRl6DQmdHcsrfNw9+eygp3QOaf4MdkCg+/6zQLq+aO1Bm+Pbi4g
         +BF24de8t53xO0NEvoZq22nBFK046g+w3XZ8rhNILI/ZjkNTt9nBn3KYbOGVi8yX1Avl
         Azx+9vv+g7iHnZ/I05FfHYvwSEnWy+rrdCxxIppQig4UU1B2hYHu6cdS9UIqCSUms66K
         hgYhbPhOAfvNYfWY7u7fBUuYII2ao/y5N5S+sCHg7WmW4RycU5UBIVBbOTD6cJLWsv6A
         kdSBcf7j/Fbt8G/ITb8L+uXHjslk2Ie2gHXDXJljSzyFuiBjlJ34ZlyjzHSRANocuXCT
         8MMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbSBun99aHSMWoz2bhDeiCtz3hr0+gqbk4o52LwEGM++AFM533I1GUezF5x6jFbP2ppQXPacc=@lists.linux.dev
X-Gm-Message-State: AOJu0YwRKX5ymz5TGGtVHxmYsAqdie96ucKlDJoN2I7Ou91eiNut9nSj
	hBn2T79SGGOhTl8zTO0xwp9HwipEJDIn0vS/e52wLJVnG7A/b28dG5oL
X-Gm-Gg: AY/fxX50bEB9gOdu60kFSbKSJtgbeXlcF3/xpNPiL2hSANHOhmfWEf5BhURVt96ICdx
	m23H1XF6czcILZVkwkvGlhvq6PB25TDDegPPsPHzKbZHTbsQgnM1/IygcgdiTdPR+K7pl0pDh95
	zs/NZjMceKs/JWkL7Ep8OmcQYQFVrIwbtJkQAmlFw9b7WH1IA7XdYp+e0KaKtGClZtiJpQRxGHv
	ZdJM/xkTrzglmDO5UCrE2djT3dO775RhovohRm25S9qivlnSuwz8mXWU/0BdgEaC1WEqifetlvn
	wrPIFkzoiU2tnKsk2vLc3n4G+tr1TgDTUEU8t4mbuNKoVz4kysB6sXDptltgIoXZJBF8YliFaI3
	AE6Xv7A5RWSlws8eE8vV9Xz3vmGL+MFR2bIQ/g9z+c+fQvOZLeDeGyCTYAgcp4qLUw3KO+vFHif
	1WteBR8gx98AE=
X-Google-Smtp-Source: AGHT+IHZqxApH7RH4SvWeJJw7f7kzbBWfG87+pyKENlTOJ0etjJH+97jX9IVf9ZouLQDPcaXmCZT+w==
X-Received: by 2002:a05:6a20:3d8b:b0:35e:11ff:45b4 with SMTP id adf61e73a8af0-369adfb3407mr9418258637.21.1765798753761;
        Mon, 15 Dec 2025 03:39:13 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c26eb0f6bsm12221315a12.14.2025.12.15.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 70D25444B393; Mon, 15 Dec 2025 18:39:05 +0700 (WIB)
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
Subject: [PATCH 04/14] mm: vmalloc: Fix up vrealloc_node_align() kernel-doc macro name
Date: Mon, 15 Dec 2025 18:38:52 +0700
Message-ID: <20251215113903.46555-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=bagasdotme@gmail.com; h=from:subject; bh=sT1prVB7LRNvf/W4XodTbc9bjm2B3700BxVWkrXUues=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4OyyibMaS/TcJdL00op76xZei7L2Pv7hFORU9uuV vT80n3YUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgInIP2BkeHzeo3teoLm8pE9N cXOPl0J5QO7s9Yesjvev3nrjTaKBPiND/5K7Lkx+c2t1WS5sWq6V/2tGhSPf8dA5nnLdX2fcuhb OBwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./mm/vmalloc.c:4284 expecting prototype for vrealloc_node_align_noprof(). Prototype was for vrealloc_node_align() instead

Fix the macro name in vrealloc_node_align_noprof() kernel-doc comment.

Fixes: 4c5d3365882dbb ("mm/vmalloc: allow to set node and align in vrealloc")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ecbac900c35f9c..2c3db9fefeb7ab 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4248,7 +4248,7 @@ void *vzalloc_node_noprof(unsigned long size, int node)
 EXPORT_SYMBOL(vzalloc_node_noprof);
 
 /**
- * vrealloc_node_align_noprof - reallocate virtually contiguous memory; contents
+ * vrealloc_node_align - reallocate virtually contiguous memory; contents
  * remain unchanged
  * @p: object to reallocate memory for
  * @size: the size to reallocate
-- 
An old man doll... just what I always wanted! - Clara

