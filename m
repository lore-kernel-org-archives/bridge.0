Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7B42404DD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C858A40298
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1679333625;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5wPFy650NtYWbMwwrvt+1dtXJ58EWb5IAcc9o8PvI1Y=;
 b=zTL/ZRzJhW62lJFASpKOBYQdzErtrgf9ZqSSsQeEZVRbBc1YfqkTNLz98GY0ae72yu
 1g1mLGKwj5iIS4Au1hpI215yodzmQCHde1NrCJ8TWu9TI8yjAhOaI8lSmBIEhWvJ+UoG
 rXlIJQF2leSmhCYNkMOBIDbUzZErlD9cWI4sVN3ujvyN2mJdNw4BgOmafBl74DVsL/HT
 zAfXZCSIspNhoE69b0PIWwy2o5klnowtDaJ0UQH+g045Ftja7rr3pzDoLkZKL8I/IK05
 X3xdImd/vRWljrhnsx0CeaO6wofasgVrmnqijfrf7Ho3FvLpEW1IpFW2/1eBdDLi/hXF
 C54Q==
Message-ID: <14361063-5005-4dd6-a314-737aaea7bf2c@blackwall.org>
Date: Mon, 20 Mar 2023 19:33:43 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <CAE2MWkm=zvkF_Ge1MH7vn+dmMboNt+pOEEVSgSeNNPRY5VmroA@mail.gmail.com>
 <a4ce2c34-eabe-a11f-682a-4cecf6c3462b@blackwall.org>
 <CAE2MWkkDNZuThePts_nU-LNYryYyWTYOMk5gmuoCoGPh4bf4ag@mail.gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAE2MWkkDNZuThePts_nU-LNYryYyWTYOMk5gmuoCoGPh4bf4ag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] Multicast: handling of STA disconnect
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ujjal Roy <royujjal@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Kernel <linux-kernel@vger.kernel.org>, roopa@nvidia.com

On 20/03/2023 19:25, Ujjal Roy wrote:
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
> On Mon, Mar 20, 2023 at 5:38 PM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>>
>> On 20/03/2023 13:45, Ujjal Roy wrote:
>>> Hi Nikolay,
>>>
>>> I have some query on multicast. When streams running on an STA and STA
>>> disconnected due to some reason. So, until the MDB is timed out the
>>> stream will be forwarded to the port and in turn to the driver and
>>> dropps there as no such STA.
>>>
>>> So, is the multicast_eht handling this scenario to take any action
>>> immediately? If not, can we do this to take quick action to reduce
>>> overhead of memory and driver?
>>>
>>> I have an idea on this. Can we mark this port group (MDB entry) as
>>> INACTIVE from the WiFi disconnect event and skip forwarding the stream
>>> to this port in br_multicast_flood by applying the check? I can share
>>> the patch on this.
>>>
>>> Thanks,
>>> UjjaL Roy
>>
>> Hi,
>> Fast leave and EHT (as that's v3's fast leave version) are about quickly converging when
>> a leave is received (e.g. when there are no listeners to quickly remove the mdb). They
>> don't deal with interface states (IIUC). Why don't you just flush the port's mdb entries
>> on disconnect? That would stop fwding.
>>
>> Cheers,
>>  Nik
>>
>>

Hi,
Alright, let's see the patch to better understand what is necessary.
Also please don't top post on netdev@.

Cheers,
 Nik

