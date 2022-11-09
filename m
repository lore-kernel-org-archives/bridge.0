Return-Path: <alishirv@protonmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB8FC403B8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F0E640382
Date: Wed, 09 Nov 2022 19:25:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1668021939; x=1668281139;
 bh=MyKsGlL0oBbIKkxurAz73K2CFqI8NWhukd85W0LmgnM=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FcyUZluUfuuRKWEpUcACTGC83uQwvj4yIMuoHcKzZbhZToupp1pjc7J+RGddXIPcx
 UvB8VzQE9qpZTcWIuXey8NU3sJ5wgeAA8VIqx8BW4sVOYYqJl1d9d21hmGaCbGaFpx
 60GP60KPbxBNbz/nuqdU9m8I86L0pCAqMHIESw993ThPAzpDicAt+/0OLRt7rv0ylz
 O3RVU+Fc1WmzmpU7B0n9SHihVxNnOlXhEAQSiP1CduncP6katuAvWfXWGW8ZYlvwpe
 sACyB/I2cPckrcRd0LdKdqkZvI+pW84AHtlLfQ3lnYOkKsDDQv1ITcfyuuUDy+qFI4
 8w6IIkqMRfTvQ==
From: Ali Shirvani <alishirv@protonmail.com>
Message-ID: <pPm5jFjNYHBUzqlDouAIg2v7XTQZJnHIVSWXoYOaTijreJ22xAZOSAcwJXHJiTLN8jIAQCs-LeX7hp9hp-FaxW-HGjn69fc6-eG3Kv6lxc4=@protonmail.com>
In-Reply-To: <20221109085109.6b0f87d3@hermes.local>
References: <nWfVbvdboX65r0xMXv0iZCj8TH7c8vStvilCD3Ilx5Y42yoHh34rJHJBMy8y4HhqXWXM0n3tLhLD870c863UjI20HBSxM8qwJlLMxuPjg0g=@protonmail.com>
 <20221109085109.6b0f87d3@hermes.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] How to connect more than 200 interfaces to a bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Ali Shirvani via Bridge <bridge@lists.linux-foundation.org>






Sent with Proton Mail secure email.

------- Original Message -------
On Wednesday, November 9th, 2022 at 8:21 PM, Stephen Hemminger <stephen@net=
workplumber.org> wrote:


> On Wed, 09 Nov 2022 10:51:27 +0000
> Ali Shirvani via Bridge bridge@lists.linux-foundation.org wrote:
>=20
> > Hello everyone,
> >=20
> > It seems we reach the Linux bridge limitation on the number of interfac=
es in a single bridge. Currently, we have 210 tap interface in a bridge, an=
d we suffer from more than 50% packet loss when we ping the IP address of t=
he virtual machine that uses one of the tap interfaces in the bridge.
> > Do you know how we can connect more than 200 VMs virtual interfaces to =
a bridge?
> >=20
> > Best regards,
> > Ali
> >=20
> > Sent with Proton Mail secure email.
>=20
>=20
> The upper limit on interfaces per bridge should be 1023.
> That limitation comes from spanning tree.
>=20
> You might bet able to improve performance by disabling flooding to those =
tap devices.
> Normally, any broadcast/unknown/multicast must be copied and flooded to e=
ach interface.

Thanks a lot for your guidance. I disabled the spanning tree on the bridge =
with `brctl stp br0 off` but the issue does not resolve. Would you please e=
laborate more about disabling flooding on tap devices, I don't know how I s=
hould disable flooding on tap devices.
