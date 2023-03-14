Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6D0A410E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D43294067F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678794752;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aedh/JywdEDddUhtE7uVGsi7gtYL/10VJ/CukUBA1H8=;
 b=vvT+5UdeB8eGOFM81g4n+k4wQ9SVBSS11dhgcVOho/2SIHAyUa6SAVGc36AQmewtqr
 ArHxEVjkZaVN2wVJgFRRnqptlu06+4lUeR9djPAcFSaeUQShiB5TM91waN7zIk0/G1JL
 k+NuPV2LOt+uCiaFDzbsRzBlHmwIHUWB3aKbrASxbtXw62tPCe6JT5sTXTffDlw9Bb6w
 GK+SKKefR7hNspP0KiFAIyKZb5FNTUvrM55zmajbOBbJjIAXJxGlLVPBaj4fYGsXx004
 fE78b1lLSyX0BeqBvP2slTilJw+vOPJffC0UwFyBSQ/SEL2EeVaRAHL7La7CGkyZqlO4
 /mHw==
Message-ID: <2097d3df-050e-ad7a-66dd-93019365b19d@blackwall.org>
Date: Tue, 14 Mar 2023 13:52:30 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-7-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230313145349.3557231-7-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 06/11] vxlan: Expose vxlan_xmit_one()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: petrm@nvidia.com, mlxsw@nvidia.com, edumazet@google.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 13/03/2023 16:53, Ido Schimmel wrote:
> Given a packet and a remote destination, the function will take care of
> encapsulating the packet and transmitting it to the destination.
> 
> Expose it so that it could be used in subsequent patches by the MDB code
> to transmit a packet to the remote destination(s) stored in the MDB
> entry.
> 
> It will allow us to keep the MDB code self-contained, not exposing its
> data structures to the rest of the VXLAN driver.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c    | 5 ++---
>  drivers/net/vxlan/vxlan_private.h | 2 ++
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


