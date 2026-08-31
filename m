Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51163B42C6
	for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179946; cv=none; b=dCBbUw89FakHXzgrHUAuSeSMzCqhfZ9lSX/2Dgla3WptpyUrCYfHDvAib1lI48nrJplyH3bPjSpsnKGGNzRuumcBERw/b6LqE4LwXc7UVupv7gqlNiJn1s/qwDZ6MWOSsFu5A5hDaNdmP1rccFnliWgpYXSBWw7uU3xdatBBXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179946; c=relaxed/simple;
	bh=5DqBNLMOOhVw3otEoFEcM4M1Ey6p4hwag4dan9Itugs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEjaHXSidlTvOWy0lJAea7kjN+R8yvZSgHICvPpuKQ5IdUgKY49oKBWlauW7GzX4q+fhKSePIizKvwGEsUd4QFIYlypWlNUkQ/OlKuEsVRUi7MCZaIfFY8HEoQx0e/2P67/1yCbq90aCPK2kl1M0dIh3hdJFn6JUpEN1rq+Ulss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=N9oCWQNQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="N9oCWQNQ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48433f36a21so1267254f8f.1
        for <bridge@lists.linux.dev>; Mon, 31 Aug 2026 05:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1788179942; x=1788784742; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AkG8VPrukE/xSkp0kXQNI9brii0c48I3Kehqjf8BMN4=;
        b=N9oCWQNQ8EZSkeKcXJKtprzRxsSKlj93LxGWqEFRj8+NaPQrdvnghjFaaTn6ZdRbHS
         NVczYgAz6YKr/k3IQ/aeEP9nxiqCwFMRgdq53y0bwALPvAASks9zP0J/jTq/elL2jsaq
         nq6BRhdmLkOvN4yIhUefFH/66ArQuwB43us+H906QyjBpxgH8D+sjhH+uJDcozwxbXnu
         J45zdGwANrjVL6AC1Pxcij4iFzWfz16DjV9HSXmuJtRO/0cu4Rjb8lKz2zYWCGpQIX4n
         faV5JLFTDaZw1JSR3lO00EIqnVVSyXvKjNLAkuZPha8oaJEp4SIgbLpGUyePQK/qXi9w
         Rm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179942; x=1788784742;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AkG8VPrukE/xSkp0kXQNI9brii0c48I3Kehqjf8BMN4=;
        b=YXKfUvUSaY7T6nuKBqrCRL66QWdyZpxq4aGOlQpWke2oUSVhJCA5hbXJlu+c7yqRZl
         bge2HNoVA8UeaI6axUJcvYCG9wXltcND7j+/3zzEJF6UHGa5sLjHzq6K1AD4HE92qWOP
         u6IPNUvPS+aau2WjYjLcn6sn8IVouWD7cqNNK3/1Z12t722NHcwcH/qAe6VFAUB7lfuc
         Kpof2ONtFXJwRGAXVa+sTHSswpqHZkD7imvrqkMxNMQHTTFnM86Sujvurb0OYknf48A1
         rRbm4/ZHWSTSoEeRG2V18u0+PTomOejOMPaJ6sFrpo44iZCE4micySvKC+YINnxd2El2
         3xjg==
X-Forwarded-Encrypted: i=1; AHgh+RrWgEZQtCQeQe7gWNoLTFQS6mOJlk56FouPcpwlI19ENwgpdb6/6WnTjDK8DF0eUSk2I+Az47I=@lists.linux.dev
X-Gm-Message-State: AFuF++kyQOxaEIj2jlO7UDW09bFfSN2WgC9Q302CzprDXpmJ/XC0iSrV
	xi/apkqi5BbivvdIDLfg8ReqPROQttvLAq0D/EcXJCNroegsnelwo+KhsoYBMcTOO3E=
X-Gm-Gg: AR+sD13HbPjDl0FlI8KCagNh05Ds7z/oc+LBKPYvsQ5TBm4o9vmLHHItm3nw8IlcUqv
	maIlvJxu7mCg4DM07jOr7HiMDJR1zw1B1J4edMBZM7frMLSeUCNjB9I2S6kNCOljRP3pIgqVwyp
	pOxEXkOrOOClkk0rL4P4Vr0qzsTlP4f/QxsvWh9BWOP2beFlIcqp06JkmRsOkc/gVGUZnaQnsny
	aXyKs9J9C4xSIa7j2WN/Nclk7dwKI42C6q76mweXRG4kX6FICIniMIch5zbtbGGoXtKT8/9WwP2
	yVwv2vDNCyJTaTh4K/XmE5NIkVDRQGSTJeZoU2SH5/6xo0KwJEutIi7BXRDXhciDBAhLwbULj6w
	sEa/FhENP96XQ1clB0AsjrNzNwNSHUcktl7zei9mZEIPQN8MT4p1LPDIWOYZOeljtRCiB4G+O1u
	OAmwpkUR0mf4bG4E13opy5HVs9sIiicmHM4ep0QVpX5crAGE854Fn/FXN5Pmw71EaQUlI0tXfdx
	VrdLvrtV/hKPTRhuQIG6AUWzo3yr8w=
X-Received: by 2002:a05:600c:8b63:b0:49c:ced9:ab7f with SMTP id 5b1f17b1804b1-49cd53c438bmr127531665e9.8.1788179941262;
        Mon, 31 Aug 2026 05:39:01 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-182.ip.btc-net.bg. [78.154.15.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cda123ac8sm26494115e9.5.2026.08.31.05.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 05:39:00 -0700 (PDT)
Message-ID: <6f0a65d0-9eb4-406c-b131-4b1a6e8ec6ed@blackwall.org>
Date: Mon, 31 Aug 2026 15:38:59 +0300
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: skip generic XDP on locally re-injected
 packets
Content-Language: en-US, bg
To: Ido Schimmel <idosch@nvidia.com>, Zhao ShiRong <shxzhaosr@163.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, bridge@lists.linux.dev,
 syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
References: <20260831113051.13072-1-shxzhaosr@163.com>
 <20260831122534.GA3247474@shredder>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260831122534.GA3247474@shredder>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2026 15:25, Ido Schimmel wrote:
> On Mon, Aug 31, 2026 at 07:30:51PM +0800, Zhao ShiRong wrote:
>> Packets locally delivered by the bridge are re-injected into the
>> receive path via br_pass_frame_up() -> br_netif_receive_skb() ->
>> netif_receive_skb() with skb->dev set to the bridge device.  If the
>> bridge device has an XDP program attached, __netif_receive_skb_core()
>> runs do_xdp_generic() a second time on such packets.
>>
>> A locally-delivered packet that was allocated on the TX path (e.g. an
>> MLD packet built by mld_newpack()) does not carry the
>> XDP_PACKET_HEADROOM that generic XDP requires, so
>> netif_skb_check_for_xdp() calls pskb_expand_head() and reallocates the
>> skb head buffer.  This frees the head that the bridge rx path
>> (br_handle_frame() / br_handle_frame_finish()) is still using, leading
>> to a use-after-free read in br_handle_frame():
>>
>>    BUG: KASAN: slab-use-after-free in is_multicast_ether_addr [inline]
>>    BUG: KASAN: slab-use-after-free in is_valid_ether_addr [inline]
>>    BUG: KASAN: slab-use-after-free in br_handle_frame+0xcfb/0x1510 net/bridge/br_input.c:349
>>
>> netif_receive_generic_xdp() already refuses to run generic XDP on
>> reinjected packets by checking skb_is_redirected().  Reuse that marker:
>> set it right before the bridge re-injects the packet, so generic XDP is
>> skipped and the head buffer is left intact.
>>
>> Reported-by: syzbot+128e9f5a0f85a51215b1@syzkaller.appspotmail.com
>> Link: https://lore.kernel.org/all/6a6d4406.2d659fcc.1d46f5.01ad.GAE@google.com/T/
>> Signed-off-by: Zhao ShiRong <shxzhaosr@163.com>
> 
> Eric sent a fix for this issue earlier today:
> 
> https://lore.kernel.org/netdev/20260831095952.3385596-1-edumazet@google.com/

Oh I missed that patch, it fixes the root cause and we don't have to do anything in
the bridge. Good thing :)

Thanks,
  Nik

