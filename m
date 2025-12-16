Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EE6330B28
	for <bridge@lists.linux.dev>; Tue, 16 Dec 2025 04:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765858721; cv=none; b=jn0Up0d2keHmmLOLLxZz87A+E1GBklDtI7WFYuMhEE08LwR8vZC7pZIEIK7Se4K26O6MxFwevQhTTC0NkOFhtUDFNLwFP9V3UVIF5MwECBbVxkfHMTqSqT/iALc/RwqkuZ9TzgW10fv47/OrTjg6oPD5bSPjLrovNy7pOKNkgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765858721; c=relaxed/simple;
	bh=8DUjCNr/nxXg5R3wmw4ZM/MLoFfePhldzOpxojnv4JY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uXVKcOwp0KFrTtmu48+Mheu7R9ykTuVSJ3bSNretDoVkbfOJTZd2k3Ri8k0Q7Vcmh5QtZexkNSTJRzbaVAOTG+aNhkG0Sj7VUzY8zV1/4m8VJDpmn9e6kSHh9Vh0ErINO7lbCcsCRodus9WRtUANVZKBLX3eAVmrROrl5p+5P5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5NjXvGD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5NjXvGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765858695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DUjCNr/nxXg5R3wmw4ZM/MLoFfePhldzOpxojnv4JY=;
	b=A5NjXvGDLxOTN7i8uepsASxQWSK+oQpP3F8+IpOowT8SlHQppyg8ggIXB/AXVsF6wvN9Zc
	e4n+5xZo2YaMJ9Jc5jT9MTjoQYNQLN37nWLpWB/8Lxdf3qMrrFknQ+bDByT9jRse1kPp7l
	hfLB5XcwzeaHGrLpxhvy11YrzrW+NsQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-aAjKcklcOSC7_VwF5e1XdQ-1; Mon, 15 Dec 2025 23:18:14 -0500
X-MC-Unique: aAjKcklcOSC7_VwF5e1XdQ-1
X-Mimecast-MFC-AGG-ID: aAjKcklcOSC7_VwF5e1XdQ_1765858693
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-341616a6fb7so4616723a91.0
        for <bridge@lists.linux.dev>; Mon, 15 Dec 2025 20:18:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765858693; x=1766463493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8DUjCNr/nxXg5R3wmw4ZM/MLoFfePhldzOpxojnv4JY=;
        b=cWZsvciOBUAhut1vEwTycryXZ2d/3pxvzMCspoW7JBAItt/Jv7FUl6Gb3mJrQ8tq7Z
         4YQgvXfAjEtUUs8DBYhoL09xneVBXio5yAYPGL+Nvso9mWfd5Wo8mpGiADhfwu61d4VX
         6jP4k0ASIpoDcFNFkqaDIK9R/1nBc5BAVv1gJMkvDhJROcttn9Q1zdVFh45m2f8YQuPm
         VfPrRQno3DdRIGJxmzZnLpXHPvmkn2LqWvZtv4K7+d7zDzgXOR5K2tZjyQVl5gSBDk3k
         Rqowv40rFOATsQi9pRDVZOSOYm87l7UFeh9CWsG3g4hEM378bClsCcWrr95RuGadQzEO
         hSGA==
X-Forwarded-Encrypted: i=1; AJvYcCVVFCkNGvDw4nblmN0atOIVrlR/bEgMKcmG3274Wyo9TcQpTC80Jq4tdfHDdd87pBSkfgxwzlU=@lists.linux.dev
X-Gm-Message-State: AOJu0Yza4y6OQ4khpmNTnREJlQW5uFv0w5gHdbEbwpXQVY0rntZgyfZn
	IdxXIKsks93wrFcbXOC35kz8E4Rjk1Ij04XTgiJg72Z4Y2rBOjKRNJLuZDCJKjmDTkIEldgI7pI
	fRjTdl2YXkdxSbLyv2RvPBvL+WRqVRY+zZ1sNw3ZjdtMel5yAKGwZCllIgYw4z/NEBiCDJwWLa2
	Jl+QeEOosPxltQ0y00yusp3hqNhOAii2YL
X-Gm-Gg: AY/fxX6FzwypMV2ari48GCHRmwj2ntuDGpc9rd/1GCtvwz5tZIL9W1+H/z+pUVOUyc9
	CY7CMVcUljT4Xr/oIPAq/BuIs+gTMULUpOKL5WM0iGM9zHDnyf29ruH9FRIUzWQ0gTprgyA+FDT
	73TklZPQRPintepaHK6AHHZyl6A8AantoFYIsPcEEIq0QMDjdPimYJa3dADjEhXG7VdA==
X-Received: by 2002:a17:90b:2ccf:b0:340:f05a:3ec2 with SMTP id 98e67ed59e1d1-34abd81733amr14699617a91.17.1765858692990;
        Mon, 15 Dec 2025 20:18:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD77DQk18dayngXtbIw3fsOCk15EBfDyLwaFsEN4158FtjFJzrWxy8+rjy6tA50q0hvVxRQAeZswAuqcmTXkc=
X-Received: by 2002:a17:90b:2ccf:b0:340:f05a:3ec2 with SMTP id
 98e67ed59e1d1-34abd81733amr14699535a91.17.1765858692536; Mon, 15 Dec 2025
 20:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251215113903.46555-1-bagasdotme@gmail.com> <20251215113903.46555-7-bagasdotme@gmail.com>
In-Reply-To: <20251215113903.46555-7-bagasdotme@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Dec 2025 12:17:59 +0800
X-Gm-Features: AQt7F2q1idGMqOnPlq5afbA61NEyezJumJNhfdWiFdPMuPeC3DZ1U_cOOaqg6iI
Message-ID: <CACGkMEtJt7Df5kXWex8EoKdakdB8_xLjgCXQt5pUvk0dkGzVMA@mail.gmail.com>
Subject: Re: [PATCH 06/14] virtio: Describe @map and @vmap members in
 virtio_device struct
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
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Matthew Brost <matthew.brost@intel.com>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
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
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0_UWJgNLPmdSDl8Fpx1ympHl9TeuzGfKfLgcISs9CRQ_1765858693
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 7:39=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Sphinx reports kernel-doc warnings:
>
> WARNING: ./include/linux/virtio.h:181 struct member 'map' not described i=
n 'virtio_device'
> WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described =
in 'virtio_device'
>
> Describe these members.
>
> Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

