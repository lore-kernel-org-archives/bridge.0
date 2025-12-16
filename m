Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BF935CB6A
	for <bridge@lists.linux.dev>; Tue, 16 Dec 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898501; cv=none; b=hEiCc+UQKUlTnYhjCpAyS7Ix1atTEO6AXV75Vvq3GPBaaxLbnxCFAOT0D/ADNqDrqeWwRuwHuxKtAPnL+b52AFDzS0pI+1ivdrWRE2EAZpdMynUxkM2/N29THjAQEfvYJ+nd07zUzBkmqEoo2UAXWP1x6O1ijqvkOrvN6SMbh7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898501; c=relaxed/simple;
	bh=kUqJrtaM24NDu8J1LFBz422ot+phR2OLYLy5w6GVNNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIhmz4Yd+SYl3BadvsaiJdq6N8Q7cmPuAPYbO6M7KjhIUTeh+Iccily4e5ccUUjPQbLRADB4TJ35ljNvmt1paVwaznFSr5SG7ZEzIr1yI29uQ5jyvXEROaXnF9qGjDzwUer016n1LnGsnLwJl1m3qacQgjPeuDzYAbArU3t4XJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc9y1yTx; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc9y1yTx"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7baa5787440so369905b3a.0
        for <bridge@lists.linux.dev>; Tue, 16 Dec 2025 07:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765898490; x=1766503290; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6A3FJy1wSkXfE42mqpxDchsxNCyuEhZg+omH3hGmm4=;
        b=Rc9y1yTxJMZKy1jKvYd6jTBlUIx2a8rRkGHRBznnCdfM5+NM/aZ6p6w1g2U8eTegE+
         CIUhNb2/pdKD196/n5U5bieFxSKy3+hU/txKD4W45FAbVrqbXSTZxYTkcT6kkQ5xojeB
         yTDWQ0cjboGguArwwjwAwyx4P/8Xe3J70nMpH11XuYymRmj/w9wlLdboA7oIAxi5AYVI
         jiNN+EUQXoW9HzLzYFllw2zAx6bTKjmrpFoXUz5GzDggfVVBfl1x59p5GdgRimhnleUW
         4yuuJyhevVNz5AvQR0JLnUW7k1guH1nTYoyyVunRHOsk3jIixN34lBGP74NVKPsme8aB
         d3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898490; x=1766503290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6A3FJy1wSkXfE42mqpxDchsxNCyuEhZg+omH3hGmm4=;
        b=U4C2Nb770JagHMGwmJkzWbrPB+SLxjKt+amizS9GPSeGTKowiB4gWhdFn9pN+EljzF
         ekW4yn30uZTicqDXV9AHlPsgIQFOOutjkhe3beBYay1BdpKe0AfEyQBW5tK052/fGSYv
         c93shE9RSKVRLH9sfuUM4+hj5sMfJWxgmanyDdjptKNmdqcE59c5PTtABzBYUCXuSyRX
         GLN/bt2q8heYAaKCxIhlCnMwnQnh/8iFuGMHUUNRtxrKBsESZ5Mw1hRvkM2KhVAybfY0
         8JJ+axuBNDSvI8gBMaWzbYyYQTFRoCYBucWLGt8jtPpTVMRIfze+XTHa7r5H9M6oDtuY
         idlg==
X-Forwarded-Encrypted: i=1; AJvYcCVle9i1gg/NEyEVJl4qiF7P9Babd6S/VWQ8GNM3Y/lJihBRiY7vCy6SH6WTQ8aGeSc93WZgbVk=@lists.linux.dev
X-Gm-Message-State: AOJu0YzFDF9svRr6bcUwngnCsveSYVU/8ZEXO2I6CpohDzNRAoDeMvDI
	WftHQ/drPEBvp7wbJam/ykGD56X3RZTlWHOw4rLk4//GY19uE7jUL8uc2hOnvGbsqSqW04ZmY0d
	AvzbkK8AUWw880Xy2zwDD88O2lldxXD0=
X-Gm-Gg: AY/fxX7wNJagOeMR7AY6IEbZ1Mbvg/c14XwWuCJuG+q91QfPjofjx86KNjMSQComgQN
	Gpm4ZI21u9r2Mn6/GPW9G/HuW3gI3UXCJoMvTh8Wb30rZVJ8LL+3cCkz0BgzYQBmcQQfz0lzCpO
	umhorCWdmDsaNHwG0DORjPxIbElkwHwvSx4EAuW0bQszgzeVthjNm4qRjYfNhqX8Q4Y+ZCpMnoh
	qIylOteZmkRQ/jnPcgzpiA8pQ5SKdeCHusDwJppRt9z9tVcyj/ygE0an7TWwD0ZeJVjK+3i
X-Google-Smtp-Source: AGHT+IFq0qaYbGK7y/3ERMab5mfBMJZm2RVpJeQ2PDWWvVrS9uWYHKl8nJo9NGLv/zMgaMY45LKm9slZF+vnfJuCU/o=
X-Received: by 2002:a05:7022:b98:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-11f34c5d690mr6648024c88.7.1765898489968; Tue, 16 Dec 2025
 07:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251215113903.46555-1-bagasdotme@gmail.com> <20251215113903.46555-10-bagasdotme@gmail.com>
In-Reply-To: <20251215113903.46555-10-bagasdotme@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 10:21:18 -0500
X-Gm-Features: AQt7F2rE8ID9d6NCh1LRY2rQdA6w_Kl1ZhHVictIiyXPuu3Pg_xadHkkj9RiiLU
Message-ID: <CADnq5_NsELxchDeka2CX1283p9mn4+P9_V9Mi+SNiWwM_sQepw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 09/14] drm/amd/display: Don't use
 kernel-doc comment in dc_register_software_state struct
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>, 
	Linux DRI Development <dri-devel@lists.freedesktop.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Linux Media <linux-media@vger.kernel.org>, 
	linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com, 
	Linux Virtualization <virtualization@lists.linux.dev>, 
	Linux Memory Management List <linux-mm@kvack.org>, Linux Network Bridge <bridge@lists.linux.dev>, 
	Linux Networking <netdev@vger.kernel.org>, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, 
	George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>, 
	Cruise Hung <Cruise.Hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sunil Khatri <sunil.khatri@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, 
	David Hildenbrand <david@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Max Kellermann <max.kellermann@ionos.com>, 
	"Nysal Jan K.A." <nysal@linux.ibm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Alexey Skidanov <alexey.skidanov@intel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, NeilBrown <neil@brown.name>, 
	Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Ivan Lipski <ivan.lipski@amd.com>, Tao Zhou <tao.zhou1@amd.com>, 
	YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
	Lyude Paul <lyude@redhat.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Luben Tuikov <luben.tuikov@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	Roopa Prabhu <roopa@cumulusnetworks.com>, Mao Zhu <zhumao001@208suo.com>, 
	Shaomin Deng <dengshaomin@cdjrlc.com>, Charles Han <hanchunchao@inspur.com>, 
	Jilin Yuan <yuanjilin@cdjrlc.com>, Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, 
	George Anthony Vernon <contact@gvernon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Dec 15, 2025 at 6:41=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Sphinx reports kernel-doc warning:
>
> WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:2796 This comment starts w=
ith '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide=
/kernel-doc.rst
>  * Software state variables used to program register fields across the di=
splay pipeline
>
> Don't use kernel-doc comment syntax to fix it.
>
> Fixes: b0ff344fe70cd2 ("drm/amd/display: Add interface to capture expecte=
d HW state from SW state")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index 29edfa51ea2cc0..0a9758a042586f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -2793,7 +2793,7 @@ void dc_get_underflow_debug_data_for_otg(struct dc =
*dc, int primary_otg_inst, st
>
>  void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst, st=
ruct power_features *out_data);
>
> -/**
> +/*
>   * Software state variables used to program register fields across the d=
isplay pipeline
>   */
>  struct dc_register_software_state {
> --
> An old man doll... just what I always wanted! - Clara
>
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org
