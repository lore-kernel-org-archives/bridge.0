Return-Path: <royujjal@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD5B6404DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0D5240298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679334091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jXsORzAzATpiIMon/GzfxOK7NLxGV8EwmaMIYBmS0I=;
 b=X3mlmfkdl1WpAb/hv+kWhBJGn/eOx9nnn8RjNStTAaTfxh9zjIzpbmxCN4LkVo59LL
 d48b7/nMnQZYfb4Xn+Fnv1AYco0fp2qMYUVGkQJCJb9u+5Q6uWGObaRQRiU7MLlKgzvI
 keEE6vI+SjAcMNrTQj+ni0Wl9iTq0mGRZwcJgvAFnUAdwFn/cxMrdkh701Ilv2Qohsrk
 eqIlvT5wLH0Oj0hMIfFJ8ZS1Xt0+hSPeV+5HEqhMk0VRY55rcMhEkMYpfYIlnQUto5jH
 P3RcfgKUfEIBzJAOMYkn5eHsT6k2QzUrVf0nhZs2SGAJkWdHDtUjzAoGsH6UEA7EMSLA
 hfxQ==
MIME-Version: 1.0
References: <CAE2MWkm=zvkF_Ge1MH7vn+dmMboNt+pOEEVSgSeNNPRY5VmroA@mail.gmail.com>
 <a4ce2c34-eabe-a11f-682a-4cecf6c3462b@blackwall.org>
 <CAE2MWkkDNZuThePts_nU-LNYryYyWTYOMk5gmuoCoGPh4bf4ag@mail.gmail.com>
In-Reply-To: <CAE2MWkkDNZuThePts_nU-LNYryYyWTYOMk5gmuoCoGPh4bf4ag@mail.gmail.com>
From: Ujjal Roy <royujjal@gmail.com>
Date: Mon, 20 Mar 2023 23:11:19 +0530
Message-ID: <CAE2MWkn=ygeVwj=j7ggLd+10mGjPJEC8Et5MGHVzs=dGWLccYg@mail.gmail.com>
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
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Kernel <linux-kernel@vger.kernel.org>, roopa@nvidia.com

Hi Nik,

Any idea if the station connects back immediately after say 10 sec?
How to resume the session immediately if we delete the MDB on
disconnect? Currently, the station needs to wait until the next
general query to come to STA.

My idea is to send a general query to that specific port to resume the
session immediately from the STA connect event. This will create the
MDB immediately and resume the stream, as we have deleted the MDB from
disconnect.

Thanks,
UjjaL Roy

On Mon, Mar 20, 2023 at 10:55=E2=80=AFPM Ujjal Roy <royujjal@gmail.com> wro=
te:
>
> Hi Nik,
>
> Flushing MDB can only be done when we are managing it per station not
> per port. For that we need to have MCAST_TO_UCAST, EHT and FAST_LEAVE.
>
> Here one more point is - some vendors may offload MCAST_TO_UCAST
> conversion in their own FW to reduce CPU.
>
> So, the best way is to have MCAST_TO_UCAST enabled and MDB will become
> per station, so we can delete MDB on disconnect. Shall, I create one
> patch for review?
>
> Thanks,
> UjjaL Roy
>
> On Mon, Mar 20, 2023 at 5:38=E2=80=AFPM Nikolay Aleksandrov <razor@blackw=
all.org> wrote:
> >
> > On 20/03/2023 13:45, Ujjal Roy wrote:
> > > Hi Nikolay,
> > >
> > > I have some query on multicast. When streams running on an STA and ST=
A
> > > disconnected due to some reason. So, until the MDB is timed out the
> > > stream will be forwarded to the port and in turn to the driver and
> > > dropps there as no such STA.
> > >
> > > So, is the multicast_eht handling this scenario to take any action
> > > immediately? If not, can we do this to take quick action to reduce
> > > overhead of memory and driver?
> > >
> > > I have an idea on this. Can we mark this port group (MDB entry) as
> > > INACTIVE from the WiFi disconnect event and skip forwarding the strea=
m
> > > to this port in br_multicast_flood by applying the check? I can share
> > > the patch on this.
> > >
> > > Thanks,
> > > UjjaL Roy
> >
> > Hi,
> > Fast leave and EHT (as that's v3's fast leave version) are about quickl=
y converging when
> > a leave is received (e.g. when there are no listeners to quickly remove=
 the mdb). They
> > don't deal with interface states (IIUC). Why don't you just flush the p=
ort's mdb entries
> > on disconnect? That would stop fwding.
> >
> > Cheers,
> >  Nik
> >
> >
