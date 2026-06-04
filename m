Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD53D7D98
	for <bridge@lists.linux.dev>; Thu,  4 Jun 2026 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562207; cv=none; b=kxKVkvGnJC/J0KrlXs1LD3Fi/y2eWbJfqo1i6ia/3cwqn+5O4oUt4VyWS+lWeHV3fFgH9aHCwRYHItrtDOMzz9fD0mIluqdt87r7tc6yTB3jvSE5IG65zhT+cG17wrKnbkWr0ZJ1Ink66DsHXTFKVp++BTpnz7ejXcm/JZuY1Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562207; c=relaxed/simple;
	bh=CBt6CTRoYgZmxlwS+t5leQNFWHs1ywfzHiZcS4OB+5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GivkHVlMMRkXBw1aciFUmsS4NsBXMqYx+8qAXwpB7y704MiFdD4b/UDXdQvTb+BZqxHN8PasWXH1WMtH6jej78V6sNTvL1Rte1a0+d1RNEl+kbEUhN6ZTn6yBG/93fVvDeuRWUl86lO+F7Wq42M50tnB6WBCeZQjtvwSzZJrv7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMfcSavJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMfcSavJ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-490a76757e5so2791975e9.2
        for <bridge@lists.linux.dev>; Thu, 04 Jun 2026 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780562204; x=1781167004; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CBt6CTRoYgZmxlwS+t5leQNFWHs1ywfzHiZcS4OB+5Y=;
        b=iMfcSavJAJ7IMHeR8v+cYZRyYXvjwY7pbNesSb1b2uSAIjGTvxY2MRYzj9z26Mst/0
         MC9CPmh6suo/RN5cUUakNIhWxx3iESoEe1cruvQEntSbI8YIXjvSfFUvd/Jtf58zwJbR
         jCaOlVro8EhTy/J5GHrYUJ0xq0zgq9le8ZbBEqXwwfUMogIlgl/raoVFQbzFwhjxj4LM
         BqZuFk5yiW+vQ5N/djjFeUFev1cvIlZHEvRorBdH5CDu0dKR6cPdg4ce7DyDIFobjNPd
         lGWqGIq0mJO/hT1BsOzT+CI8chZbXZRUEia76TQQHP49BE85hPISwxQ3LBdt1ayt75wJ
         NhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562204; x=1781167004;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBt6CTRoYgZmxlwS+t5leQNFWHs1ywfzHiZcS4OB+5Y=;
        b=l9828k+cWaLgTTcK3ODTnhq3aNdhvANuekh4ZecL51A7U/YJ2+Dv+RYoPpWlKsowRH
         7hZaeegJ/693lv80eRZK46coRITvXs9khLi0mP1TGsVjFkMAKfNE17C52NqQSYNgAAjG
         FHrgS8j7Fn9qrWxOBGi9EbVvpaD9yRUR3SecSvI0odD0qMlzDtuMrGSG91dQMzCI6NKc
         ovBddB1Nroyn906x5RDnhm1OT1hHVGmgAnVBDDZxIwhVnC5AI4XjqHYhRrhnQkn0y8HB
         7SHC8frbavomroPxLxMlZW/DBG/3enJX+BvOxe+Zv+IpImRh1QlfBeEfrtAfiQODDHzz
         Nx5g==
X-Forwarded-Encrypted: i=1; AFNElJ8o9texHfhHgm43XDYOjPQRTGneWb7lbZY1PEHzY0nzj7I5Svf2hJ/OlEhYcc2RaDsp/XFPq1k=@lists.linux.dev
X-Gm-Message-State: AOJu0YyeqQCLnB3MkVrzhpSi1VuT8lYxo7dF0+y4XAlKhwr4HFMysxJF
	obczHxonBZLNU9JtWMkuSjypt+7a+jzaaC35Y/JOQ8lp4sMjfaI8sQ7g
X-Gm-Gg: Acq92OFR80DJmBQSdRsIqTlJLJj03F3S8/VWd6RGFjN+AkXkfnIL/YancfCt8gtqbZr
	Xz9pxM6odhpbZfHPLWKx56jdC0yaBE9bu2e5hl6QvFRzdeBsrQ32BMYiU+DEK4aX7DWaKLcl743
	KITl/W1opROResxJq3ygazWRvB2RGm3iKuI6S97UCj3kLniKhh/vIHqSIDZ9/jU8CfD3OdQIDnx
	TGXgBmDGXEeulNJei6HpNnmeoURvRiS4465LKvp/8iRbgPXEZXvi+1tCYPAHKwWV4Nuw8sXALhl
	GbJ/2WLfziUSShbDy0qU9tW/ViSMCSbM7agyPYkz7sFsjuGbLtqr+1j/dYFsZWsVvj32uo6qLKi
	7/64i83KJLIY4XEBW5Do5iYxrWZdr4WLu9NFsXcOhJEk61HpC7IyhA7f7+x2O4xqoR7vfXqMpXB
	VCkLifrI0hYRfaAsZWNlBFhzNEAhIqW0z0YXSM8cgjC1J2USn3swRzNnsZr4YhRT6Fv9HmwiINu
	tSgdDdeVnvRIjKNp1AxwZCXHqEzdko0NMvpYBdVXNja4lI=
X-Received: by 2002:a05:600c:8184:b0:490:b3f1:e41b with SMTP id 5b1f17b1804b1-490b60e20b2mr104501265e9.26.1780562204213;
        Thu, 04 Jun 2026 01:36:44 -0700 (PDT)
Received: from cedric-laptop (2a02-1810-cd14-9200-6809-bbad-785c-8e80.ip6.access.telenet.be. [2a02:1810:cd14:9200:6809:bbad:785c:8e80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3918fcsm61056715e9.3.2026.06.04.01.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:36:43 -0700 (PDT)
Date: Thu, 4 Jun 2026 10:36:32 +0200
From: Cedric Jehasse <cedric.jehasse@gmail.com>
To: Luke Howard <lukeh@padl.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bridge@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>
Subject: Re: [PATCH net-next v2 5/6] net: dsa: mv88e6xxx: MQPRIO support
Message-ID: <iwlidn7t36oax3t3y6o5jr3bfm24t3uw4g2toqam3izkmafnxy@sphgjtjrkqg2>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
 <20260602-mv88e6xxx-8021qat-mqprio-v2-5-72be14522e7c@padl.com>
 <t44kmhk6gqxnwhdvo7svouexwelwsya7zgukpbv3cxpfsmutqa@y3rjoj3tvqce>
 <808529B1-E40A-4E54-A654-86F1B6D1FA66@padl.com>
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <808529B1-E40A-4E54-A654-86F1B6D1FA66@padl.com>

O Thu, Jun 04, 2026 at 07:36:07AM +1000, Luke Howard wrote:
> I realise I misunderstood you: this is about exposing the 6390’s egress FPri to PCP mapping via DSA/DCB rewrite? That’s really cool, and orthogonal to MQPRIO; apologies for my confusion.

No, it's about configuring the ingress pcp to QPri mappings.
The patch has been submitted to the mailing list:
https://lore.kernel.org/netdev/20260604-net-next-mv88e6xxx-pcp-prio-v1-0-f9d10fe6cdc8@luminex.be/

Cedric
