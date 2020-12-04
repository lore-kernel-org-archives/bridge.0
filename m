Return-Path: <Joseph.Huang@garmin.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com;
 h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps1;
 bh=s9AwL8mZyEkWKFjJfD1YRSi+5QbLOdQkxOuRumwLvoo=;
 b=dN64vp8T7er3yN25aMzE19aHZWnXj2dfw9XVx+IWb793GtdCdxKUQ00QNu9xElgWyL4G
 +7n7AxA0IlasrPAl250oBkmceJygybdCZYt5p5hHMYxPa4s9cs69jtfd8M376TNZQuuh
 AOfTxpaoGZqT2zE74CQFUu13pCiJdLTV2TdNKRXeeBtQYimCbfDC23l0xQgxq1wmnvTl
 PqYulBvhPROW000l74JejmnviRYlvEmTv2Zw7dZWtgdgAbNReQLr98Zwcwpiwn3JerMP
 /xuRuKwrvqfo+QxQhYX9ZA4hL5eVkT6IQ2k5XZ/lonbEzWEqwSRwX0elarvDsZweKoXP Mw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9AwL8mZyEkWKFjJfD1YRSi+5QbLOdQkxOuRumwLvoo=;
 b=1CIUKwf6UXlIa0pM3XStbxBvKG7GAsV0xHn1a1Ex2e8tqQv0cvwWG8WKrvfszv2hqVZtqt0QQtVMu1InXXHd0UGhbyj9XQ7czg6xnSuTuaqVIHrH20D4JBNdJkMZt1u48hJQI3PH9K+SqSnOdkAJd2ofyTaomuaGusCgpN3Q9ARdkuizt3BSiqyv8C8zkykdl4QM4aftIK0ixNg5vqKdG2gntfh65uCQNjZ53MwymmGffxeevrkf/S6Nu7MXdBmxPxuQl1yg8unP0Rjbx7d8Uj8N03ddJMA2XltxP/NzTGJsjtI5zcATIdJP7WerscCzVt5NeCHVThl7tVddMnNkQQ==
From: "Huang, Joseph" <Joseph.Huang@garmin.com>
Date: Fri, 4 Dec 2020 22:30:22 +0000
Message-ID: <977913cfd91b4c6d8fb2e25d8762aaee@garmin.com>
References: <20201201214047.128948-1-Joseph.Huang@garmin.com>
 <20201204213900.234913-1-Joseph.Huang@garmin.com>,
 <f771d272-3146-2d8c-391d-87d1db8b8e76@nvidia.com>
In-Reply-To: <f771d272-3146-2d8c-391d-87d1db8b8e76@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Bridge] [PATCH v2] bridge: Fix a deadlock when enabling
 multicast snooping
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> > +     if (join_snoopers)
> > +             br_multicast_join_snoopers(br);
> > +     else if (leave_snoopers)
> > +             br_multicast_leave_snoopers(br);
>=20
> If I'm not missing anything this can be just 1 bool like "change_snoopers=
" or
> something which if set to true will check BROPT_MULTICAST_ENABLED and
> act accordingly, i.e.
> if (change_snoopers) {
>     if (br_opt_get(br, BROPT_MULTICAST_ENABLED))
>          br_multicast_join_snoopers(br);
>     else
>          br_multicast_leave_snoopers(br); }
>=20
> This is not really something critical, just an observation. Up to your
> preference if you decide to leave it with 2 bools. :-)
>=20
> Cheers,
>  Nik

I wasn't sure how expensive the call to br_opt_get is, so I used a bool for=
 each.

I just checked and it seems that br_opt_get is probably just as cheap as a =
bool,
so I'll change it according to what you suggested here.

Thanks for your comments!!

Thanks,
Joseph=
