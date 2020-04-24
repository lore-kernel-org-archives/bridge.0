Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=sDwVLjRBMPWU6wEqJr0n/7TaaBKOSB8AM8QuUjXpRFg=;
 b=PFmeDn82LqDvfQ32uAq3qNbtzdFMdsCBiPHffUqPmJU35TDpn6p3vUhwu4z9ydA+1w
 bOCnHg07doepYRJy1qQfHA8PfJfz32xzpmPG8epQ8gKLESNSrZIpLVh1OGxeZrRzmyUs
 Akipi/z1KazdqSXjtV6JSC9rJJfEXqhyGF7Tw=
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
 <20200422161833.1123-11-horatiu.vultur@microchip.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4c2200b5-5173-eac3-1cf5-14538a0b5d71@cumulusnetworks.com>
Date: Fri, 24 Apr 2020 16:49:09 +0300
MIME-Version: 1.0
In-Reply-To: <20200422161833.1123-11-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 10/11] bridge: mrp: Integrate MRP
 into the bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net, jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org, roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch, UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 22/04/2020 19:18, Horatiu Vultur wrote:
> To integrate MRP into the bridge, the bridge needs to do the following:
> - detect if the MRP frame was received on MRP ring port in that case it would be
>   processed otherwise just forward it as usual.
> - enable parsing of MRP
> - before whenever the bridge was set up, it would set all the ports in
>   forwarding state. Add an extra check to not set ports in forwarding state if
>   the port is an MRP ring port. The reason of this change is that if the MRP
>   instance initially sets the port in blocked state by setting the bridge up it
>   would overwrite this setting.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_device.c  |  3 +++
>  net/bridge/br_if.c      |  2 ++
>  net/bridge/br_input.c   |  3 +++
>  net/bridge/br_netlink.c |  5 +++++
>  net/bridge/br_private.h | 31 +++++++++++++++++++++++++++++++
>  5 files changed, 44 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


