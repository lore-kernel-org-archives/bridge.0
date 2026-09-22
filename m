Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840752E07F
	for <bridge@lists.linux.dev>; Tue, 22 Sep 2026 08:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066818; cv=none; b=TXGHviBxkmkyQ3ATgt3TjMn5XzgP1v9x2MwSQxdOEq/9jgGccYQu02gGjmzOCPzlT/2tmKJIgGbQeIG10ZeWVVzqg4Gg8u5GBeauUddm2uLUJIU6rqkidHcyVYKu513Z4EpKO5YN3xR2Warl59QwGRgEUqAwz5lAjta4u8WRtPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066818; c=relaxed/simple;
	bh=hEj5nL9MRpMH+JX12YZNspzZFd1+3Fuf+CZGgePMxM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DZEvTbh83MzhWd23V6O+827pk9sEkP9d/H+z4oqmd46mKb6xPz5fjW+8ICR+UKtTuXb80Duv0afA3K8hfA9xXEuTo2sqPyiaem3k1mjfwqiT5/T32vD3OWmB2ldwUQE7Bi2R0ndH4cT3LaGLC/vve8xGVGAfsAdvkcRGC6yNEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IYBKNLtQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYBKNLtQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790066815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=;
	b=IYBKNLtQq8wTUycH85md9ifO3UzdBdQpmXnhcI9WuMUbzlJTZb2nJoqTJfUGv/jkxW+2df
	Q6/0abTDQLcb41eolbGg5OtlRpucdzzl5QIHymKupyLRdX/r9s70yGIJ1MliJgs8JNm5Z+
	SWpooAx5kvmxb+KysJsp5NFMcJny9wA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-WVjjtLyZO4GYugpUqQfwqQ-1; Tue, 22 Sep 2026 04:46:54 -0400
X-MC-Unique: WVjjtLyZO4GYugpUqQfwqQ-1
X-Mimecast-MFC-AGG-ID: WVjjtLyZO4GYugpUqQfwqQ_1790066813
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso49783345e9.1
        for <bridge@lists.linux.dev>; Tue, 22 Sep 2026 01:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066813; x=1790671613;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C95bRAv5IkFCsxK5LjzncGYLGpBLHTNK6JTZFhyWW0M=;
        b=PzGbU9HV/UtyzZcsCqAH+GLLa8I8eEmUSLzNkeq4hoDqBXJ3zlK5kRD7+g9QraA/nV
         5MiF5HyXgP9nFNP2kbOXPibv7iImArVac1jwj8DYpvAv/epqFPpjI3mW3ZpLVgXMPPLn
         Hlx/8uHBvGaN0STlot3KOZRWgvSji4ko8R2+Blt8JVxRztN47xFnlJFI4PACrRvj446r
         tvOayxLU19fYB1l6fwBbaYwnK91ty9k1koWNBH+oclE/7xZQFRv0UJoiNjhE7RvbhUf/
         wlXGf6a5Q9feOakStunAAlg6AIiys07fLCCa2xPLkVx199/uiGTEMwBsCfU88YqXJ/Dl
         YYUA==
X-Forwarded-Encrypted: i=1; AKwUvBxOyKeSIRJNRZBPtWr55IzaCQ2SzVoH8Q1Ve7LNZ5Vjqlnz2uu2Gi1lDKqjkuJn7x2xqhI2HTM=@lists.linux.dev
X-Gm-Message-State: AFuF++ltXR7+ICKhc8BU82s/0mHU1/jBSkbnxVeNmAwEI/OInzX54Hfu
	WE9X0z0++lc/zRR+nvaIoBNvH2mTMfYKc72L3qEOkokCoBZ5dNLBsPlnvOm+LmsOFT1E2qzjyzN
	II9x0Ygv72BhNjom/7RQaZLrcoVREKybPQUVY1z6apz40R973/RJlOblk+A==
X-Gm-Gg: AYBFou3LRekmRfj3MSrNuZlVZGHbjAOLuRP3ebXiQxfkDNTtk0F1bXnN7Hr4uonpxma
	hwYxJb6sNV0DLNZ+R5KKtqW3S5OdAizeTRZFGtO+bwh/0Y3f5bO5BfbmlLWjRd3a1lNO3OFoPQU
	e8jAfxeoK0kPzlJU13o36y9SdiaNW9dFh86V6MSLA1Flz02i7qjQUr5on5qGxswMB9HE1iClixx
	Ol5zcYhWtbTxV/pxaq6pdpvoZ5OOSkoFzqsxmqRgNVel02eHTIhGbbZqXIaQBjne8ZxX4a0tuR6
	pPHmGjKhCPf6hwXfZkXzuW8K0XiyvW1vU3I8wJNhOEM/uCzc1tlWW2PskeNsNr/V7lI5ilb1uId
	8xwyciL193zQ9O+K9Jh3Txcg=
X-Received: by 2002:a05:600c:19cd:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49fc5695861mr190094915e9.13.1790066813181;
        Tue, 22 Sep 2026 01:46:53 -0700 (PDT)
X-Received: by 2002:a05:600c:19cd:b0:499:7a15:fcec with SMTP id 5b1f17b1804b1-49fc5695861mr190094445e9.13.1790066812661;
        Tue, 22 Sep 2026 01:46:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm65246905e9.8.2026.09.22.01.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:46:52 -0700 (PDT)
Date: Tue, 22 Sep 2026 04:46:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Paulos Yibelo <habte.yibelo@gmail.com>, netdev@vger.kernel.org,
	richard@nod.at, anton.ivanov@cambridgegreys.com,
	willemdebruijn.kernel@gmail.com, jasowangio@gmail.com,
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
	andrew+netdev@lunn.ch, pablo@netfilter.org, fw@strlen.de,
	phil@nwl.cc, razor@blackwall.org, idosch@nvidia.com,
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-um@lists.infradead.org, virtualization@lists.linux.dev,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v6 1/2] net: validate virtio checksum start after
 network header
Message-ID: <20260922044627-mutt-send-email-mst@kernel.org>
References: <20260922030310.8684-1-habte.yibelo@gmail.com>
 <20260922030310.8684-2-habte.yibelo@gmail.com>
 <20260922005353-mutt-send-email-mst@kernel.org>
 <aa560d2d2cbf94e50397740159c12e24e0ecf820.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aa560d2d2cbf94e50397740159c12e24e0ecf820.camel@sipsolutions.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tUgm-LIURdpW2bjugOXNDgy25i5tN1oetNFGaoAA9sc_1790066813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2026 at 07:56:23AM +0200, Johannes Berg wrote:
> On Tue, 2026-09-22 at 01:14 -0400, Michael S. Tsirkin wrote:
> > 
> > >  
> > > +/*
> > > + * Return the L3 offset and protocol of an Ethernet frame starting at skb->data.
> > > + * The offset is unused without NEEDS_CSUM, so avoid parsing and return zero.
> > > + */
> > 
> > for networking code multiline comments:
> > 
> > /* always
> >  * look like this
> >  */
> > 
> > /*
> >  * never
> >  * like this
> >  */
> 
> This, for the record, is't really true any more - we dropped the special
> rule a few years ago.
> 
> johannes

Oh good to know. thanks!

