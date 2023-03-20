Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04ABC81990
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1085481975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1679314103;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0DX4qBiGcGPtOV8eO23GpfgYZaEoud4OZh0owe5T4Xc=;
 b=ob0cCOvHCgx+sWCZcQWup1xlVWDWoiFVDCN3lJ5IhUATuzhYyZIUey29e8g18Js2WI
 g41ZkxBkZni+Bdb+IrhCVneXhRxHfRPkXKCCFNB0DVSs6duRKr1ngXfmHVvIfzsXBG1L
 6VU/SrBQnPlHWS24n4AjmKzpUaky/lmrXXDkwQDJ5CT2Db8wZ/3utkVonf8uZWZofizx
 pUNfNYcIeCZ/bwQx2NGnc/dWUqnl1sjZsTNSU3nPldjC45GW4uDUalitIiq4wK9hfS/E
 M9XhTCFkT06Tzwi1eYzBNDe11812UszSD2W/mwlqxbJO0j8belRghMoYiAiDPCQW1wiD
 pxUw==
Message-ID: <a4ce2c34-eabe-a11f-682a-4cecf6c3462b@blackwall.org>
Date: Mon, 20 Mar 2023 14:08:21 +0200
MIME-Version: 1.0
References: <CAE2MWkm=zvkF_Ge1MH7vn+dmMboNt+pOEEVSgSeNNPRY5VmroA@mail.gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAE2MWkm=zvkF_Ge1MH7vn+dmMboNt+pOEEVSgSeNNPRY5VmroA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Multicast: handling of STA disconnect
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ujjal Roy <royujjal@gmail.com>, roopa@nvidia.com, nikolay@nvidia.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Kernel <linux-kernel@vger.kernel.org>

On 20/03/2023 13:45, Ujjal Roy wrote:
> Hi Nikolay,
> 
> I have some query on multicast. When streams running on an STA and STA
> disconnected due to some reason. So, until the MDB is timed out the
> stream will be forwarded to the port and in turn to the driver and
> dropps there as no such STA.
> 
> So, is the multicast_eht handling this scenario to take any action
> immediately? If not, can we do this to take quick action to reduce
> overhead of memory and driver?
> 
> I have an idea on this. Can we mark this port group (MDB entry) as
> INACTIVE from the WiFi disconnect event and skip forwarding the stream
> to this port in br_multicast_flood by applying the check? I can share
> the patch on this.
> 
> Thanks,
> UjjaL Roy

Hi,
Fast leave and EHT (as that's v3's fast leave version) are about quickly converging when
a leave is received (e.g. when there are no listeners to quickly remove the mdb). They
don't deal with interface states (IIUC). Why don't you just flush the port's mdb entries
on disconnect? That would stop fwding.

Cheers,
 Nik


