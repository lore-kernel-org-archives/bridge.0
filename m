Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6605814BA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86DC6813D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9XfzzI0aJv3Oy+nsDPy+TYtpW6ng2Irz9hGaMbx6s3M=;
 b=5rhHSPdoK0FJ67VKVFj4aFRHClNSijowYb9fWpJW4uJ68ApzouzjidnMg3ri3TJjgR
 AvUhX2TFYEBy0Cvgu4B4hI/MTBl7BHWx4nf60ae5M6cjCIXKbDbA9itdkc7t1vx+/jJS
 vCIMuXA6tJGEIEKZ9afWTbSJM6igKlg/E4njTvoJEvhWAPyhZCWEm6dPlMfeJ/OTEZek
 Hrw1z0SYsCuZohYRB4Kr4wY5eo/30rkvHOR8vuCIFIBfvc4vLR9bwTtCBvhJU3WGdSl7
 U8vaIBoDFokDorDz744nvY6yzYKzH0GNNG8C1CwuS6UXj9ONUAe9/51w+IOX3gmHq3Bm
 +sDQ==
Message-ID: <dbcb7016-2473-0586-b6e2-2a42fca2b7f7@blackwall.org>
Date: Sun, 29 Jan 2023 12:10:22 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <3ca0fe4de1f701befbc874e4b672c90aee602199.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <3ca0fe4de1f701befbc874e4b672c90aee602199.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 12/16] selftests: forwarding: lib: Add
 helpers for checksum handling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org

On 26/01/2023 19:01, Petr Machata wrote:
> In order to generate IGMPv3 and MLDv2 packets on the fly, we will need
> helpers to calculate the packet checksum.
> 
> The approach presented in this patch revolves around payload templates
> for mausezahn. These are mausezahn-like payload strings (01:23:45:...)
> with possibly one 2-byte sequence replaced with the word PAYLOAD. The
> main function is payload_template_calc_checksum(), which calculates
> RFC 1071 checksum of the message. There are further helpers to then
> convert the checksum to the payload format, and to expand it.
> 
> For IPv6, MLDv2 message checksum is computed using a pseudoheader that
> differs from the header used in the payload itself. The fact that the
> two messages are different means that the checksum needs to be
> returned as a separate quantity, instead of being expanded in-place in
> the payload itself. Furthermore, the pseudoheader includes a length of
> the message. Much like the checksum, this needs to be expanded in
> mausezahn format. And likewise for number of addresses for (S,G)
> entries. Thus we have several places where a computed quantity needs
> to be presented in the payload format. Add a helper u16_to_bytes(),
> which will be used in all these cases.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


