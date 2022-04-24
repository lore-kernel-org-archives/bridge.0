Return-Path: <eng.alaamohamedsoliman.am@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=/+H/N/gmFAaOe4y0s+SRcJl0SyQ/fuybtesfMfHNNuQ=;
 b=L9/LRThN/qmaxvltFgT3Vsp3alFuHmSCHX8niKbw5nVt0f+GrPKdM+saUo8/tdJ5DH
 m0AMCUG97D2qOpTUIUhPAB1LV2EacwAKSkyzmxv7BAnp+FzQ0W1Dfp7aQ6g2Ix+jAcBX
 35TfCkIhfMG+4YHd7moTBuvU6uDfQXEaYt4XDpjRLD5/WLBjvosQIWGdQADpLpI+nMsN
 0Mxumf9sFHFtGBjiLKgIKfaXSlO28LuwSn0ICnECFbMeLP+6QU8d+Lj3jo5i/imkxMNP
 wZTeV39Gk0h/+2Jmf/KEcMr76MLwIWnpqzdk9D175he7a8eCIkDfw/iAcNcHdeLa3fz7
 18ag==
Message-ID: <f06389af-d665-03c1-6256-5c9bbf89a321@gmail.com>
Date: Sun, 24 Apr 2022 21:20:51 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1650800975.git.eng.alaamohamedsoliman.am@gmail.com>
 <0d09ad611bb78b9113491007955f2211f3a06e82.1650800975.git.eng.alaamohamedsoliman.am@gmail.com>
 <alpine.DEB.2.22.394.2204241813210.7691@hadrien>
 <06622e4c-b9a5-1c4f-2764-a72733000b4e@gmail.com>
 <3b8c790d-9e90-d920-9580-8e736435f7f3@blackwall.org>
From: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
In-Reply-To: <3b8c790d-9e90-d920-9580-8e736435f7f3@blackwall.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next v3 2/2] net: vxlan: vxlan_core.c: Add
 extack support to vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, Julia Lawall <julia.lawall@inria.fr>
Cc: shshaikh@marvell.com, jdenham@redhat.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, alexandre.belloni@bootlin.com, outreachy@lists.linux.dev, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com, sbrivio@redhat.com, claudiu.manoil@nxp.com, anthony.l.nguyen@intel.com, roopa@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, UNGLinuxDriver@microchip.com, intel-wired-lan@lists.osuosl.org


On ٢٤‏/٤‏/٢٠٢٢ ٢١:٠٣, Nikolay Aleksandrov wrote:
> On 24/04/2022 21:52, Alaa Mohamed wrote:
>> On ٢٤‏/٤‏/٢٠٢٢ ١٨:١٥, Julia Lawall wrote:
>>> On Sun, 24 Apr 2022, Alaa Mohamed wrote:
>>>
>>>> Add extack to vxlan_fdb_delete and vxlan_fdb_parse
>>> It could be helpful to say more about what adding extack support involves.
>>>
>>>> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
>>>> ---
>>>> changes in V2:
>>>>      - fix spelling vxlan_fdb_delete
>>>>      - add missing braces
>>>>      - edit error message
>>>> ---
>>>> changes in V3:
>>>>      fix errors reported by checkpatch.pl
>>> But your changes would seem to also be introducing more checkpatch errors,
>>> because the Linux kernel coding style puts a space before an { at the
>>> start of an if branch.
>> I ran checkpatch script before submitting this patch and got no error
> This is what I got:
> WARNING: suspect code indent for conditional statements (8, 24)
> #366: FILE: drivers/net/vxlan/vxlan_core.c:1137:
>   	if (tb[NDA_NH_ID] && (tb[NDA_DST] || tb[NDA_VNI] || tb[NDA_IFINDEX] ||
> [...]
> +			NL_SET_ERR_MSG(extack, "DST, VNI, ifindex and port are mutually exclusive with NH_ID");
>
> WARNING: line length of 111 exceeds 100 columns
> #370: FILE: drivers/net/vxlan/vxlan_core.c:1139:
> +			NL_SET_ERR_MSG(extack, "DST, VNI, ifindex and port are mutually exclusive with NH_ID");
>
> ERROR: space required before the open brace '{'
> #377: FILE: drivers/net/vxlan/vxlan_core.c:1145:
> +		if (err){
>
> ERROR: space required before the open brace '{'
> #389: FILE: drivers/net/vxlan/vxlan_core.c:1164:
> +		if (nla_len(tb[NDA_PORT]) != sizeof(__be16)){
>
> ERROR: space required before the open brace '{'
> #400: FILE: drivers/net/vxlan/vxlan_core.c:1174:
> +		if (nla_len(tb[NDA_VNI]) != sizeof(u32)){
>
> ERROR: space required before the open brace '{'
> #411: FILE: drivers/net/vxlan/vxlan_core.c:1184:
> +		if (nla_len(tb[NDA_SRC_VNI]) != sizeof(u32)){
>
> ERROR: space required before the open brace '{'
> #423: FILE: drivers/net/vxlan/vxlan_core.c:1196:
> +		if (nla_len(tb[NDA_IFINDEX]) != sizeof(u32)){
>
> ERROR: space required before the open brace '{'
> #430: FILE: drivers/net/vxlan/vxlan_core.c:1202:
> +		if (!tdev){
>
> ERROR: space required after that ',' (ctx:VxV)
> #431: FILE: drivers/net/vxlan/vxlan_core.c:1203:
> +			NL_SET_ERR_MSG(extack,"Device not found");
>
>
Thank you for sending that , but I don't know why I missed that when I 
ran the script. Anyway, I fixed all these errors as Julia said.

Thanks again,

Alaa

