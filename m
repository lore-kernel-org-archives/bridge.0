Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D9C4581419
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E6D3813EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WGEur4ZImg+eboS3WKEGWQySrzE5jLwrJWc4aJbdxO8=;
 b=Upyq9ukTht74rZcR5Xt5AYL8dRAaLLsu2mgmtKAlw27RORtnQVTR/cMugKdJn9133p
 jb8EyEeD2MMWQ460sVZiATkzfBitfITUgIkqPdkFtNNrF/n/KztvFAL8kRokBp58E/bC
 OZbciMu2pXLcRkEevNng74DoWr+KCF/UbaPvHr+RioJIac8vTx82xDp3rPMbTXU3aoTQ
 3a/Is+PsG9awAP11q2fjlUxY2fyB+UZ0sx5xLOsznHP86J15+YaSiOWUN3okCunhLJgD
 iXRgqC2NAvEykBYdwX7GpBEj4yJCzDuW05wdFmUZjgvbH9mW0eg+fSkrKzS87SFQkk4j
 z/cA==
Message-ID: <7fd7a5a3-2ca9-d42c-f0a7-5b03760ab507@blackwall.org>
Date: Sun, 29 Jan 2023 12:11:35 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <273051ca0cae7bcd2957e44803fed128efc80336.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <273051ca0cae7bcd2957e44803fed128efc80336.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 14/16] selftests: forwarding: lib:
 Allow list of IPs for IGMPv3/MLDv2
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
> The testsuite that checks for mcast_max_groups functionality will need
> to generate IGMP and MLD packets with configurable number of (S,G)
> addresses. To that end, further extend igmpv3_is_in_get() and
> mldv2_is_in_get() to allow a list of IP addresses instead of one
> address.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 22 +++++++++++++------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


