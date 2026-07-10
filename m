Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75783D8103
	for <bridge@lists.linux.dev>; Fri, 10 Jul 2026 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674657; cv=pass; b=a4dP0XaG6lrCVcL9ZuB7NBN3sByuOntDAAzretvpmK0vBci67JQW9vkSc/tmqQel7KpkH54eXICgcy3mQoBkipGw22jY5CZOvR6vLIdtPpfRiEWzI+40XjGy1YY4jYS7Ug91oxs0E5jSDBh4ILanrRZGYWCjtVaZ1v1IVQs5jw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674657; c=relaxed/simple;
	bh=7VRjjiYf7VsPZRU72hng4qVFsOX57FJEhq69ROQS9W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+wcQcYi/cQaegWV2BZeU6GOeSwNvuiLzDmxBV211VdViP5znO6K9In74npS9LqYkhHDtR2raa8EKljwpWPAj9lMCDrCWSTz0bIrIPe5X+pDNoVFun9/C9urTLwyhu35rDPHxCjE//eu4z0Xr6I3jHFlwieIlthiEFfBObtlIyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFQ+DExv; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFQ+DExv"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15c257a488so117745466b.3
        for <bridge@lists.linux.dev>; Fri, 10 Jul 2026 02:10:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783674654; cv=none;
        d=google.com; s=arc-20260327;
        b=eh22q0MrybHpTuzk3pne4ImkGZ3yVLnojAmCy2Sn0H5S2bW7Lr2FmoAZ924k4SQPv3
         /6jI3wEjuAARp87J0kNRZV2y1J8l0bfv2F6lDS+5JNhaTb6Wx86oPLtbJz3izJBABhWb
         wG9R2Ltn1oNTer+uLghpkpZqL1i9XIne0Y37HVyelGPWg+8d1Wi25d6nfrPfy9+9ibHM
         FjIQ7XPtwJpxw/9WSJL77KdmqJSLOQPy8Q2Qx9OPFCZpkcTgS/9n7dyG9HzQejrwX38l
         SuwFz9uSICyOrbd5IJ1fl6Gzr+VoG9VJ1foUESTEg/i8Yv8lgL1GCAsidlI7bjhKt2eK
         uTTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=63OqeDSCaj1h6ZXr3VoxtulDj7w9Hpihc2AgE3wNxBI=;
        fh=0eg1lQ9zXXhmGDx2huq/Q90SK5QAeeezvSpUZL+nSJY=;
        b=kYG9HQ46tkHiQmyKu+pB7JvJVOkdSObYhwwR8dDI9mez+trxrVgUMBONsFt0gSLNlF
         HV1w0+QLKnOv/wCYu9Uj1Z4nYOxqlqRKPETnExMSjBrrTq6NCuF5skHoBxOdsDmkPVbh
         hdj4Exjd2J4rEXNbl67bYPXDNgbwXxrneUWtsahANqFhGIT3N5mwqy3NGjKsYCDxBRQk
         z7c0+OAbra2U3KvDeLLR9gppJPUT4vkx0mjEwbE4SjiUAT7dmfUDJSv8yMaIXaqOCMCU
         hO5NNss5+ecX6hhCO577VclrcEF0PvqvSrCqYTmszFJzmglgqz7T9naqp06FGYuj1JsY
         Na9w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783674654; x=1784279454; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=63OqeDSCaj1h6ZXr3VoxtulDj7w9Hpihc2AgE3wNxBI=;
        b=PFQ+DExvgDjYxryV+M5ToR5WB9CTf12hzrlb/dXcaVZEvdqqoqDN2JLsbZaRfsYcRT
         32M6KyOfVMv1YKvf65/5E9SwQMuvy+Tm6c5kaLtx6oabcrwW9nd1A5mtR36kdj0Ly++O
         Y/zLuWvt+TdrdMOW4TBrZWaVeqDTsbqEJ+V+v8IcOew0wZtFsBwKnZg2rhWq/llSfeUk
         Vi2agwHzdHyMdjeWVPbLQwIJbu/vAzmsvPXwecr/vr84mph5QT32NlOrgqqEA6Im/mR9
         Z46pYnBMF3dm11vOxE5rR0nWqSP7h9r5IAPC1bsvK6V1rZPt6TXIQ+2uJMMjsWOumGaY
         K2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674654; x=1784279454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63OqeDSCaj1h6ZXr3VoxtulDj7w9Hpihc2AgE3wNxBI=;
        b=fzcvWNTbLSE6VVePq3t2CNUyPNugvvsxiwyGT9pAn9SLnXuhCxwCMKjNESd7gTbka3
         GEE9snk9EQkcthbLgXucEtf8eyQP4X2Hwq86Qeiio/e3i20uyRH8sdcgz92cfNW1p/oF
         o4dAGQp/05kDwSDFz4ZADtGTiZ/1PErc01BOAMBQmXJRb8i6nMWePctgclKqFcdQboi5
         nNUvjOjgZ/kJ0K0MdrfMSv4uOqqGS8bPKuhoxxdvTy9xI8xMY47z1To7W0fhAi31EXwz
         urWNHVBAgRAk7LOlxGAaCQEMJ2guVgft+sNWGr44/d47cFNUgJVMGs5cJY7vjvBk/dWu
         RK7Q==
X-Forwarded-Encrypted: i=1; AHgh+RpG/81pXRJJMJzE9YAZiaII+1JMa0jBtWXMWetdYr2ELUrQxc7zaSGW4zYyYtZXghq3cD7dLE0=@lists.linux.dev
X-Gm-Message-State: AOJu0YyFQ9B8rYWh/7y+Trv9a/oWkOUxFK9erzxHl5h2BJtPcf15Xkl5
	8yRwNRNquGWpp+ldTIvyH37PWVIn2BrggwUVteaE3xVp6I+46q8AG0N+6KXAQ2r3VO/z40D+ASM
	j7EV+UXGwrzQ9azpZXOPj05F7hID99Lg=
X-Gm-Gg: AfdE7ckX2A+oyYLxkEhC0fhS4v9XQBRC1fuwbFewy5OhnHM1OQLGBjeycFzC6BaWfDJ
	qn12Bp7YaS561iy9YcuQ1XRUa//mLo0oFiPq/UQE62khTmmcIV4FDLvaME+jMn/9gfOcEvd7wKa
	DGhTN17OUjfir7VOXBMsHL3OPv2YniN9GmglUE1rH3feSc0hxYfxuewuQDnBsnYe/U5rs16wfJs
	lOAOaleTf4A5P4lqBrmky+cBjF8HzzXKzBKh2fw5t0MoFHT+0t8QGghCy87XRtJ0YI4b9hm/eQs
	ZXxjSw==
X-Received: by 2002:a17:907:d641:b0:c12:3c96:83a with SMTP id
 a640c23a62f3a-c15ce14468dmr473366066b.38.1783674653759; Fri, 10 Jul 2026
 02:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
 <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
 <2026070954-activist-left-8303@gregkh> <CAE2MWkmcQdhGp3LTMtpgAse3AFcfKcAcpQe89+iijfP5e0w_QQ@mail.gmail.com>
 <2026070948-lively-exchange-a458@gregkh> <CAE2MWkn3L7V3x8i0F-soGLxsBBo_Umgs1pJ3FwCw1OW7=U55zg@mail.gmail.com>
 <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch>
In-Reply-To: <14350a31-ffc7-41fd-84d3-6cfb2cb96841@lunn.ch>
From: Ujjal Roy <royujjal@gmail.com>
Date: Fri, 10 Jul 2026 14:40:39 +0530
X-Gm-Features: AVVi8Cd5znmWkFPkHNasW53XA8Yxqr82wjkGlYTTGZ7zlu8uEaTgeVqYBL6bRu4
Message-ID: <CAE2MWknt86W6yCtuS_RupiuwiDqXT8wZqENM2DjiW1R=eY8qdg@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Andrew Lunn <andrew@lunn.ch>
Cc: Greg KH <gregkh@linuxfoundation.org>, Linux Stable <stable@vger.kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 1:31=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > History: The multicast stack currently supports decoding of IGMPv3 =
and
> > > > MLDv2 exponential timer field encodings, but lacks the correspondin=
g
> > > > encoding logic when generating multicast query packets.
>
> RFC 3376 says:
>
> 4.1.1. Max Resp Code
>
>    The Max Resp Code field specifies the maximum time allowed before
>    sending a responding report.  The actual time allowed, called the Max
>    Resp Time, is represented in units of 1/10 second and is derived from
>    the Max Resp Code as follows:
Here I can give you some input. Default value is 10 seconds for which
the protocol value sent on the wire will be 100. This means 100 *
(1/10 second) =3D 10s. Similarly, setting just 14 seconds will cause
issues. The protocol value transmitted on the wire is 140, which, when
decoded as a linear value, results in 224. Similarly, values greater
than 25.5 seconds cannot be represented directly in the 8-bit field.

>
> Let me check i understand the issue. If the user configures a value >
> 127, linux continues to use the linear encoding, but a peer decodes it
> as a floating value.
Yes, you are right and that is what it does till now. And the Kernel
applies same to the QQIC field as well.

>
> 128 linear is 0 | 0x10) << (0 + 3) =3D 0x40 =3D 64. So the peer sends the
> reports earlier than required?
No, it is not 64. This becomes (0x10 << 3) =3D 0x80 =3D 128 again.

>
> 255 linear is (0xf | 0x10) << (7 + 3) =3D 0x1F0000 =3D 2031616. So the
> peer can send the reports much later than the 255 1/10 of a second
> than userspace expected.
Yes, you are right. But the calculation is incorrect; it becomes
0x7C00, which is 31744.

>
> What is useful here is, 'maximum time allowed'. The RFC does not
> appear to say how to pick a value between 0 and the maximum time
> allowed. Which gives us some flexibility.
Yes. However, this can lead to excessively slow membership
convergence, increased leave latency, and in some scenarios may cause
multicast membership state to expire before reports are received.

>
> I think a much simpler fix for stable is to clamp the user space
> request for setting the max response time to 127. That seems like a
> one line patch.
In mainline I encoded the value according to the RFC. We can clamp to
127 in stables, if we are not willing to take the entire series. This
will force user to use value < 128. Also, please consider QQIC; a
similar encoding issue persists.

>
>     Andrew
>

On Fri, Jul 10, 2026 at 1:31=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > History: The multicast stack currently supports decoding of IGMPv3 =
and
> > > > MLDv2 exponential timer field encodings, but lacks the correspondin=
g
> > > > encoding logic when generating multicast query packets.
>
> RFC 3376 says:
>
> 4.1.1. Max Resp Code
>
>    The Max Resp Code field specifies the maximum time allowed before
>    sending a responding report.  The actual time allowed, called the Max
>    Resp Time, is represented in units of 1/10 second and is derived from
>    the Max Resp Code as follows:
>
>    If Max Resp Code < 128, Max Resp Time =3D Max Resp Code
>
>    If Max Resp Code >=3D 128, Max Resp Code represents a floating-point
>    value as follows:
>
>        0 1 2 3 4 5 6 7
>       +-+-+-+-+-+-+-+-+
>       |1| exp | mant  |
>       +-+-+-+-+-+-+-+-+
>
>    Max Resp Time =3D (mant | 0x10) << (exp + 3)
>
>    Small values of Max Resp Time allow IGMPv3 routers to tune the "leave
>    latency" (the time between the moment the last host leaves a group
>    and the moment the routing protocol is notified that there are no
>    more members).  Larger values, especially in the exponential range,
>    allow tuning of the burstiness of IGMP traffic on a network.
>
> Let me check i understand the issue. If the user configures a value >
> 127, linux continues to use the linear encoding, but a peer decodes it
> as a floating value.
>
> 128 linear is 0 | 0x10) << (0 + 3) =3D 0x40 =3D 64. So the peer sends the
> reports earlier than required?
>
> 255 linear is (0xf | 0x10) << (7 + 3) =3D 0x1F0000 =3D 2031616. So the
> peer can send the reports much later than the 255 1/10 of a second
> than userspace expected.
>
> What is useful here is, 'maximum time allowed'. The RFC does not
> appear to say how to pick a value between 0 and the maximum time
> allowed. Which gives us some flexibility.
>
> I think a much simpler fix for stable is to clamp the user space
> request for setting the max response time to 127. That seems like a
> one line patch.
>
>     Andrew
>
