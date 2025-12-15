Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19341330B06
	for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798755; cv=none; b=KU4ABDGhrV3BpWNo83WGPnOlfCMJVVbxUHISHSRje3+u6onEQxhUzvQ+HaB3K0YIu5GfoKcvKp1i7MLTfgyxY6j7Y0/5YO0oMlOrN3qC38/660NptlEP2LTdunYUziVvBNcXutJsytzgiE9m7uQ3N4WkhpTDDtPGt5phul2OFdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798755; c=relaxed/simple;
	bh=1tOY86lhWOCbSHsqmK/tuDEilXGPwKXl/15tM3wSixs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMvWu8vFsYIRar9VnJoxurFnTDlH7shEQjvZszmT23pkbPIkyEAax+hTY6vHnnEwyGJcG8eyYNqEHKf7GUaHsJtv5uQLN5QUAAVRepdPLREp8WhNhMM1goqjv7C1rTzLA7UL2gLCtQb+tUA/0V8KFnPxXwxD3i4ptFLy5CJ0gJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8a1ZrUa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8a1ZrUa"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a07fac8aa1so22150585ad.1
        for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 03:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798752; x=1766403552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWXueLrhDneeDmCGizpSHzMSgAg8yMgxTmeT/qXEn+I=;
        b=D8a1ZrUa+nrcapP4dQnsSwp/9oYjNhxR2FB9IyeKX/1DBMvsHYx4teYLO1l3cU7zcJ
         IgpcU+NCYF5paCmPS6gZMeCwEQe2+97Z8rCYuxRTDQmOWcz15qoXqykv94ICbEVIlXUB
         lmj0k7zs2aQIKgnI1SiqjX58SrDxrc5cC2xhgIxQMLVjLm9Lx2t549o4eKbVhsBok7UY
         +Iuw0wB+G1hJFE3ro1s57IbZQMzru4FqJmPfidb+8090g4plmoYEicH1iU1Q+yE+T5YI
         oxnkNib3wNi2AGhwQ2pl0zeuiFL4IVGjTD7HPYeEs1CxAQMnsxX4cGEBUZeOk1AKioU3
         6n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798752; x=1766403552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TWXueLrhDneeDmCGizpSHzMSgAg8yMgxTmeT/qXEn+I=;
        b=HowyLzvLtmKd35hV4ppnaBmsE7UodccHvUWKK/jSxdGGpPJvI5FIzONjwYmYmbtL1m
         GyP+rIT3zloLWmqNq+vGYp8cs/Pf/aXOBFl+lY3/MSBEsuBPH+BfJhggnc72stZv4MyH
         iwdCRSRE8RbDsUyTHck/DFZnHjkHiC8Y/X+pLnOGoInVVIWIZo6d2zYvyfr/7QrdM0WW
         wJY7fDmuEE4KezGntopPs7Nmgpv3Dsp7j3sRomRC4YaF4JpB4Eoo+f6ot3hyVmJ2UQf+
         njbDAZlJeOnbf+CNYdKXhPplNwpzqQ8kC/w9oFFCoGUzahsTtqsmmSRrA8lvKCslCHNt
         WA+g==
X-Forwarded-Encrypted: i=1; AJvYcCWp79eJT/LPMK1953wqQCxdgAIIzUQ9ijDkDb9qIePmPyQHIAE0haZb/1dnTFJFn7zwdvAzNLg=@lists.linux.dev
X-Gm-Message-State: AOJu0YyLV7N2E1VAYgoDd3rXyKzINesGzdSR4qWwiuySPE0GvyXclLJ+
	YMKkrWZAOsr/sO5V2hMn4M5Y8Obi/fHOtOpDReHNGzxZu3AIk82GVrum
X-Gm-Gg: AY/fxX5WbnIqzeoRLVpLcrFi7rU7n3PNF5z+6ryqn33QYmPdZSO/cu7b7OTiyvA2Wlk
	n5w1bmgicpsSZr9EJERYBExrej63U0uki/KJznb4WrqrLuMQ+Jnq5HbVWaAO7uhHiRdyScDcun7
	g0uomKd8RDqIE43yLdT3ZWzhvn6LassTegHIJpgeQbwmf2OMxdK2pqzXQ+djHlpGk9Xv1NpM6/K
	QPiIvvxlu613GRwg4ePCPdKQC5v+tQ8G/Sbh5KQ0T0sOHZU38PtnwP+1CzaAljZsRPbnfRI1v4H
	sFIPJTDtTyFbIIWTnDO2i1acD8ZyTlkVkUnO30whuRnQaAD199dCltbeyby3LMrABIo5Kb+Oov0
	dS490+K/fCm8GL7ZSHwWeimar8DYMRPMkzDX20WwXttLPn8UXnCjcuOzDn37LnYesx8aobsGdeI
	D1+R7c3+S2n2g=
X-Google-Smtp-Source: AGHT+IHBwyvn37cMWft6XaLu78i521F3TitB1ZgZCjrLkgz/dWJXwkRq1mT1+qz6m/LgaTgF4rxTDQ==
X-Received: by 2002:a17:903:3d10:b0:2a0:a4b7:44af with SMTP id d9443c01a7336-2a0a4b74893mr49683665ad.26.1765798752075;
        Mon, 15 Dec 2025 03:39:12 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d36ddcsm132733715ad.32.2025.12.15.03.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:11 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 504F3444B392; Mon, 15 Dec 2025 18:39:05 +0700 (WIB)
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
	George Anthony Vernon <contact@gvernon.com>,
	Thomas Graf <tgraf@suug.ch>
Subject: [PATCH 03/14] textsearch: Describe @list member in ts_ops search
Date: Mon, 15 Dec 2025 18:38:51 +0700
Message-ID: <20251215113903.46555-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=896; i=bagasdotme@gmail.com; h=from:subject; bh=1tOY86lhWOCbSHsqmK/tuDEilXGPwKXl/15tM3wSixs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4Mqzx7cbGl2s1Xb5iYDm7bLkws+2881173X3pa/f UbeT2+PjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzk0hqGfzoRZw50iXbWS+pV RRyxzVGfNT/eQV3w9+MclUw9PumMlYwMO5cdc7i131P/rrG85octa1tun66WP3rW6W/Ropnr7E6 G8AIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./include/linux/textsearch.h:49 struct member 'list' not described in 'ts_ops'

Describe @list member to fix it.

Cc: Thomas Graf <tgraf@suug.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Fixes: 2de4ff7bd658c9 ("[LIB]: Textsearch infrastructure.")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/textsearch.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/textsearch.h b/include/linux/textsearch.h
index 6673e4d4ac2e1b..4933777404d618 100644
--- a/include/linux/textsearch.h
+++ b/include/linux/textsearch.h
@@ -35,6 +35,7 @@ struct ts_state
  * @get_pattern: return head of pattern
  * @get_pattern_len: return length of pattern
  * @owner: module reference to algorithm
+ * @list: list to search
  */
 struct ts_ops
 {
-- 
An old man doll... just what I always wanted! - Clara

