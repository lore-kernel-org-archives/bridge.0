Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A7C137C38
	for <bridge@lists.linux.dev>; Tue, 27 Feb 2024 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028299; cv=none; b=FUEadM9iKAj5HDg0iMrw8yvXhiojjwCtwTLdyaiYvSVnoZSpzV9hNYBsS3hJoxcTf2fMhmhv17ZPaMNUJavLlKR3GH26DVNvvj+O5WZl3AxMsfIECwgHgR7qgCapu6oPkHvwdcRKkja82daC0Hh6ZZmytkO0yYBm6/DOD3g6vWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028299; c=relaxed/simple;
	bh=TbfbzWsT6RMZp7nigPLL2/4ItyCjpPNpo3gk9ktJBRg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efFatxjnR4AqK/xE4ikMmE+73iDxoEoPdfB1mFun5IaFe1/pmzmzPVkwKf2i7olsbOow+9TPI4W+GvXTeBvcfIzHUs2n1k8VzazwmF999flwY7oD9JlwT1bSJtni4OrUn5+c9i8H+u267gee6GoiBDpCSq3qWbtuf+HAHycPAYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUBLiaBz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUBLiaBz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709028297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ykkuCZsMlECnKdA2l3L8RqASyZxrWVrhEW9ykrGz7Co=;
	b=dUBLiaBzjBIsG6+YwJobnVDBkXx/OxZPy/CFrol/NKUcDypCRVO60B0Vq4w25sWAarpJ18
	iOxR/ouauzCElILj1XdYjEYUDq8K58YjOO/W6wJgQt7NR3jEtEsRXIVvzX2tYe347/OsNn
	lmZ0fmPVh9y2drgznLDyvokzEpViiOc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-73to66H_N-SwnmozeclW4Q-1; Tue, 27 Feb 2024 05:04:53 -0500
X-MC-Unique: 73to66H_N-SwnmozeclW4Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-410adb15560so6702085e9.1
        for <bridge@lists.linux.dev>; Tue, 27 Feb 2024 02:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709028292; x=1709633092;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6muMn14FheoVfzNCsTsdUaWpYsZjCl+tJQPQ611mM2I=;
        b=bOD+AgKOb3grubS4/DNUuYfBV92UYuhgzLVUPNqxPUrgWU7wEB40Aj3B6xNdxcYWhO
         BDvUPCh0rugIqSTwS5bOTTSSoSuaY563Ax+bbwBmKhkPf5w8HgpRstqXgasV7w2vOy0p
         fnI4UVWu9qCrm3JQ+q1vky6DiQZtCxzucLx6T9Gzek7TUscMUAcvvRvSGQG9Mw/+U+8z
         guyUT5pI9uHA2vIWjYcecrQtis8acCw7LO/WgN4rrcbAoOz6upJlvV/CtscOIw+61x0G
         ac7lA0B04mtBR0isqBlHn2CXi+tddW/9hMJ21a2AKU434FXhEihlZikZSQllr+tck4tg
         j2Qw==
X-Forwarded-Encrypted: i=1; AJvYcCUPWnKkQ50Tt9h6aUGj++6Go1hZyFFg+6v/0RKkyMvbyrR5rpyoWy6iIgpZ6mRLc3wCPrWAER27iGtNhaouJJo/1fTCIc3n
X-Gm-Message-State: AOJu0YxJ5vz5NB7k9uyB6fjt92w+2yokyUU131jiS/uvB7+uk25Q63bV
	9XzHNHuSOzkr1MGRVqX8XaJtZy9e9uI6j5KVJMwSj4uc6sl9iYggXEsdQj6duJVJ9H++AvBNNLt
	CXxNLnM/8bv+w5xAyxoQjfDUakne9XtgYInIwSkWz6CvtT/QTFt2YTw==
X-Received: by 2002:adf:e182:0:b0:33d:873e:ee41 with SMTP id az2-20020adfe182000000b0033d873eee41mr6758137wrb.0.1709028292554;
        Tue, 27 Feb 2024 02:04:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH20dt5TK8LB+RIqg+qbIG355QxBd6y4DoqoyffQqwcSOCV30koTUr4MRU89rDOIPL2U+7kng==
X-Received: by 2002:adf:e182:0:b0:33d:873e:ee41 with SMTP id az2-20020adfe182000000b0033d873eee41mr6758127wrb.0.1709028292179;
        Tue, 27 Feb 2024 02:04:52 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-60.dyn.eolo.it. [146.241.245.60])
        by smtp.gmail.com with ESMTPSA id dq2-20020a0560000cc200b0033b483d1abcsm10841507wrb.53.2024.02.27.02.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 02:04:51 -0800 (PST)
Message-ID: <4838ad92a359a10944487bbcb74690a51dd0a2f8.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
From: Paolo Abeni <pabeni@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Tobias Waldekranz
	 <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
 razor@blackwall.org,  bridge@lists.linux.dev, netdev@vger.kernel.org,
 jiri@resnulli.us,  ivecera@redhat.com, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Date: Tue, 27 Feb 2024 11:04:50 +0100
In-Reply-To: <20240223103815.35fdf430@gandalf.local.home>
References: <20240223114453.335809-1-tobias@waldekranz.com>
	 <20240223114453.335809-5-tobias@waldekranz.com>
	 <20240223103815.35fdf430@gandalf.local.home>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: bridge@lists.linux.dev
List-Id: <bridge.lists.linux.dev>
List-Subscribe: <mailto:bridge+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:bridge+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-02-23 at 10:38 -0500, Steven Rostedt wrote:
> On Fri, 23 Feb 2024 12:44:53 +0100
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>=20
> > Add a basic set of tracepoints:
> >=20
> > - switchdev_defer: Fires whenever an operation is enqueued to the
> >   switchdev workqueue for deferred delivery.
> >=20
> > - switchdev_call_{atomic,blocking}: Fires whenever a notification is
> >   sent to the corresponding switchdev notifier chain.
> >=20
> > - switchdev_call_replay: Fires whenever a notification is sent to a
> >   specific driver's notifier block, in response to a replay request.
> >=20
> > Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> > ---
> >  include/trace/events/switchdev.h | 74 ++++++++++++++++++++++++++++++++
> >  net/switchdev/switchdev.c        | 71 +++++++++++++++++++++++++-----
> >  2 files changed, 135 insertions(+), 10 deletions(-)
> >  create mode 100644 include/trace/events/switchdev.h
> >=20
> > diff --git a/include/trace/events/switchdev.h b/include/trace/events/sw=
itchdev.h
> > new file mode 100644
> > index 000000000000..dcaf6870d017
> > --- /dev/null
> > +++ b/include/trace/events/switchdev.h
> > @@ -0,0 +1,74 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM=09switchdev
> > +
> > +#if !defined(_TRACE_SWITCHDEV_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_SWITCHDEV_H
> > +
> > +#include <linux/tracepoint.h>
> > +#include <net/switchdev.h>
> > +
> > +#define SWITCHDEV_TRACE_MSG_MAX 128
>=20
> 128 bytes is awfully big to waste on the ring buffer. What's the average
> size of a string?
>=20
> > +
> > +DECLARE_EVENT_CLASS(switchdev_call,
> > +=09TP_PROTO(unsigned long val,
> > +=09=09 const struct switchdev_notifier_info *info,
> > +=09=09 int err),
> > +
> > +=09TP_ARGS(val, info, err),
> > +
> > +=09TP_STRUCT__entry(
> > +=09=09__field(unsigned long, val)
> > +=09=09__string(dev, info->dev ? netdev_name(info->dev) : "(null)")
> > +=09=09__field(const struct switchdev_notifier_info *, info)
> > +=09=09__field(int, err)
> > +=09=09__array(char, msg, SWITCHDEV_TRACE_MSG_MAX)
> > +=09),
> > +
> > +=09TP_fast_assign(
> > +=09=09__entry->val =3D val;
> > +=09=09__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)")=
;
> > +=09=09__entry->info =3D info;
> > +=09=09__entry->err =3D err;
> > +=09=09switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_=
MSG_MAX);
>=20
> Is it possible to just store the information in the trace event and then
> call the above function in the read stage?

I agree with Steven: it looks like that with the above code the
tracepoint itself will become measurably costily in terms of CPU
cycles: we want to avoid that.

Perhaps using different tracepoints with different notifier_block type
would help? so that each trace point could just copy a few specific
fields.

Cheers,

Paolo

