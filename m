Return-Path: <royujjal@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 506DB81B48
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6D5D819BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679333129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFjbf1hqGKTeNG29GCna0olkfNIXH80B4W/+/wvwthc=;
 b=Jk98EvIs3B0BqU2BquE5gMDbTQB25Jebzbw0h43Pu2Si3wDTISCQ4agjC+8N4iUURS
 5yw8yeqwYdg4l44DJr09Q1YC43CVGhARn2dFQKKnTVr1x2e88UpHOZTfN9KrRqtQM0pW
 4SbAzUj7gt/0OxewlcWqBVhYihaxfIcqABO1tEP7yldeCSQgWyt7gumrVPw/8mBN2hft
 I4ixCRnCK5BWBbAwKYCtcc6X5CMvMehQSPOr1YncIwUvQ5RkullWQjXoT63q5jAIU3ZF
 2DXOhk163onSWhAaVaozEQZvwUZWzaoagCrJXCpWypa+vpC/VktyVyEt7fg/hO1bEoW8
 pp2A==
MIME-Version: 1.0
References: <CAE2MWkm=zvkF_Ge1MH7vn+dmMboNt+pOEEVSgSeNNPRY5VmroA@mail.gmail.com>
 <a4ce2c34-eabe-a11f-682a-4cecf6c3462b@blackwall.org>
In-Reply-To: <a4ce2c34-eabe-a11f-682a-4cecf6c3462b@blackwall.org>
From: Ujjal Roy <royujjal@gmail.com>
Date: Mon, 20 Mar 2023 22:55:17 +0530
Message-ID: <CAE2MWkkDNZuThePts_nU-LNYryYyWTYOMk5gmuoCoGPh4bf4ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Multicast: handling of STA disconnect
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@nvidia.com, Kernel <linux-kernel@vger.kernel.org>, roopa@nvidia.com

Hi Nik,

Flushing MDB can only be done when we are managing it per station not
per port. For that we need to have MCAST_TO_UCAST, EHT and FAST_LEAVE.

Here one more point is - some vendors may offload MCAST_TO_UCAST
conversion in their own FW to reduce CPU.

So, the best way is to have MCAST_TO_UCAST enabled and MDB will become
per station, so we can delete MDB on disconnect. Shall, I create one
patch for review?

Thanks,
UjjaL Roy

On Mon, Mar 20, 2023 at 5:38=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 20/03/2023 13:45, Ujjal Roy wrote:
> > Hi Nikolay,
> >
> > I have some query on multicast. When streams running on an STA and STA
> > disconnected due to some reason. So, until the MDB is timed out the
> > stream will be forwarded to the port and in turn to the driver and
> > dropps there as no such STA.
> >
> > So, is the multicast_eht handling this scenario to take any action
> > immediately? If not, can we do this to take quick action to reduce
> > overhead of memory and driver?
> >
> > I have an idea on this. Can we mark this port group (MDB entry) as
> > INACTIVE from the WiFi disconnect event and skip forwarding the stream
> > to this port in br_multicast_flood by applying the check? I can share
> > the patch on this.
> >
> > Thanks,
> > UjjaL Roy
>
> Hi,
> Fast leave and EHT (as that's v3's fast leave version) are about quickly =
converging when
> a leave is received (e.g. when there are no listeners to quickly remove t=
he mdb). They
> don't deal with interface states (IIUC). Why don't you just flush the por=
t's mdb entries
> on disconnect? That would stop fwding.
>
> Cheers,
>  Nik
>
>
