Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3283F8146A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 94E9981468
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112; t=1678794731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pmNZdygJnAQ23YxPeMcptEgBWA7szbpuBbBzvQMSVCo=;
 b=UHIeTIbhvVf49zjI8NtD5Z6zlDH3+WhDYKavKzAoMJFNFURrBBrVECTacuI1buZ3Ss
 lMryy8VP8NaUyzaPbmy/jBKC6VJuvhMGAdVwqw7agzj7gDv3COpSLtoCPfn6usL5Ql2W
 cPVlfrrd2f1MVNI/BQ2GMMRzVlBkVlueDb/mfXTzr/WstTqS+fLTRzusnZbbynv7/+Se
 4o/SWQr3DznAC8AfU+lCAV2+6WSrjROYJD61mJf20mx70nRUP7PMMI1EdHF96BfKPQvY
 aCwyXJDK1eCtpvJ6146bTRVcha/ZA513ivMKsuh6RzF+DVcdpfoMWmxplJ6g/hQ8Z8l4
 0MsQ==
Message-ID: <8300e3cf-39d7-55bd-2614-db581fcfdc65@blackwall.org>
Date: Tue, 14 Mar 2023 13:52:09 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230313145349.3557231-1-idosch@nvidia.com>
 <20230313145349.3557231-6-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230313145349.3557231-6-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 05/11] vxlan: Move address helpers to
 private headers
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
> Move the helpers out of the core C file to the private header so that
> they could be used by the upcoming MDB code.
> 
> While at it, constify the second argument of vxlan_nla_get_addr().
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vxlan/vxlan_core.c    | 47 -------------------------------
>  drivers/net/vxlan/vxlan_private.h | 45 +++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 47 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


