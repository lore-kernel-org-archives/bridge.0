Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F933033C
	for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798756; cv=none; b=bLvPKRK65iUXKwyO1+4J3aNJUYqHh+PEcGyu8JxTJOT6AIh5OHs/Gfj7R3Aiq/prwA9OO9rldtLo6gZ8lsRdBcI4oA3irHGtTqpGHN4iRkbo8nQ9Jvq5IVJE+3PyA0rXH2UOZKehf08jzqOlI4hhvRJYtCky6FcUwaR7N84RnF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798756; c=relaxed/simple;
	bh=mcnZ1soLgF/JTT1YuxC/XOQhVy9SZYDoshinxHejwDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsxypBZZywD+7+a6DaT7BfNWiAFU/vn2nk//hcF7yES14sHnVvobKIQs25jZlB7kzEW9sqASYY9ikMQ7Jm353mKBGNYAuOKzB+OQ0L1HfHMOBHwWlwT96fTYaKfHJqGbyJwGYLkkmJn6Duijrb+/AOjt6kHlsZ9Z+fMZWxGaZzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdBftdP3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdBftdP3"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so3571821b3a.1
        for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 03:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765798753; x=1766403553; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lORwJoeOdmqWvp6Gaq9g1tKkad6KEP5mAC3mejLEu6E=;
        b=FdBftdP349nLejfls6LKo/rM4kB8Y+a9rr9Spq+3G67gCTYqJHPeThSAxszWUy+4pl
         pa5ZvhQBmgnLM+nADC6z4h0cj2c/TWh3XaAqwYdRmIYZ64nIXuVoJ/oATI7K+SUnrzFL
         jyyGLoCIjhWoOAZ94xx/Vr8ajphT9rAQ7v2ntDsXmyvumMbjgOR/CWLehLA1+sE2hxA2
         k0eDoN7nB76GwxJvj2cTrq9l//fHgNfv0ePLg7XQITKd81MqYd+4jWRIPMg76LzNSIM7
         qs2eXSUCrkZ6TNaNWPtAsTqvyiCNtF7j8LADVDJbAz2X1OiAoKhmBKXg2bmOnSoEFfeF
         WQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765798753; x=1766403553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lORwJoeOdmqWvp6Gaq9g1tKkad6KEP5mAC3mejLEu6E=;
        b=L+WV3cZUP3yjMzal3EA/pEdG0ZzNGBMJb7uAz+4GD6H3hbhsqbnS/EZsGcSw6QjEnS
         zww5x1Z2OB13kEkUDuEOpI0ib3ZGX8EszVaf/B0yRt4bymr2cCizpMBmrS2XxAa4Ii9F
         WiLRILpmSZLUzGYZFdMP8T8QTJwY8+fHsBsp/iNDv+z0l12baUsYlOW8P1PlYm/T70Q+
         +IvuYn/fT20hprDsojIJAMFRQCo+mVCwSegaUoygD21K3N5IwXQCyQLyOnULVLbFwdKp
         lfc68cS/v32z0DJMi6MFNn8Ljnq9qgDC3lTOtp2qKjWdzAH9tUxcfExXW7JDADZsHVGn
         CNkw==
X-Forwarded-Encrypted: i=1; AJvYcCXupz/9A4LPC2NjJE8zTfw3vbuc2v36MAVDpYxOuxcC3aiWtiMupN0N1nVom7E7KQaNULh3mX0=@lists.linux.dev
X-Gm-Message-State: AOJu0YziHYvWNxXtTtlKooMm/EeNaweWlc/2svmqC5gwPzD1JwxlLFXJ
	FmGhR75B8MccgfpKwUoJx5BglwLt1XrIKycrXBfGsGjc5uCeMg+IizFC
X-Gm-Gg: AY/fxX5XNryY92AjYBflcWIlMzRDt1PeHBzRkn2fjAxBE7jGBJipaaJQ3RRoCY3Uo/t
	31vog0AFYDPEKWJeYlzHFd1ZiaAcAdO+i1D7JMiUoXZZ7rtiJ6ZugZ8MYAgfeI5gMtMeeClpAl8
	Tx/ZFt7F9jo2FKfZ8Kvet8FrK8pBLxTpiykgfcR4Albl7cTdzYnqPwYlAD88z1H7RYDw14Y3aEi
	9ttE2RioDh+uOebPkUgWsG5eg7D1TtLYKfcoPPHWcadYgZX3FzH6usBt2yA/cL7/i0wLqFH/GJ8
	pINZ8Ct7ZwDb/NZzFH9jCvgQDPnlDpizawNZQ+XFHQTLBSpt/fU1+6hGoL8PofXptlGnb4vwfz0
	NB0U7NohhjJcKAA4z5OmzU/U5BEjMZrqmA/MS9ZOzzchxrr9XJFkZ1X4vx1mEFR2LC5BdaTdX83
	2snAaNYRIG+50=
X-Google-Smtp-Source: AGHT+IH43ZxDlO+sXZpKsRY9ws0CLb4ZSMlMGi8iin8W4Uc9EL2/AE6hhR6bEKC++ztievLapVcsEA==
X-Received: by 2002:a05:6a20:6a28:b0:364:387:8f4e with SMTP id adf61e73a8af0-369ae490337mr10620715637.34.1765798752795;
        Mon, 15 Dec 2025 03:39:12 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c0c2ae4e3casm12755809a12.21.2025.12.15.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 03:39:12 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 811FA444B394; Mon, 15 Dec 2025 18:39:06 +0700 (WIB)
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
Subject: [PATCH 05/14] mm, kfence: Describe @slab parameter in __kfence_obj_info()
Date: Mon, 15 Dec 2025 18:38:53 +0700
Message-ID: <20251215113903.46555-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215113903.46555-1-bagasdotme@gmail.com>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=849; i=bagasdotme@gmail.com; h=from:subject; bh=mcnZ1soLgF/JTT1YuxC/XOQhVy9SZYDoshinxHejwDU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJn2n4P0Tdf6vI2dt8iwUrrPLU6ToytxCmtRXso3wY/50 fGG9Ws6SlkYxLgYZMUUWSYl8jWd3mUkcqF9rSPMHFYmkCEMXJwCMBHZKwz/nVbIB4ee2zunpOHQ vBz35Ga7xwYL3V6/ES+tt/jmsMTsOCPDXNsiGd24sMjVrB9Z5rD2NZvPm8/+bp/rS8/i2IdH8rc yAgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Sphinx reports kernel-doc warning:

WARNING: ./include/linux/kfence.h:220 function parameter 'slab' not described in '__kfence_obj_info'

Fix it by describing @slab parameter.

Fixes: 2dfe63e61cc31e ("mm, kfence: support kmem_dump_obj() for KFENCE objects")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 include/linux/kfence.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index 0ad1ddbb8b996a..e5822f6e7f2794 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -211,6 +211,7 @@ struct kmem_obj_info;
  * __kfence_obj_info() - fill kmem_obj_info struct
  * @kpp: kmem_obj_info to be filled
  * @object: the object
+ * @slab: the slab
  *
  * Return:
  * * false - not a KFENCE object
-- 
An old man doll... just what I always wanted! - Clara

