Return-Path: <razor@blackwall.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29926813EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78DDD81374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XSjzv9oX4nqKyAAaAAV6s7LVl26vtY1MqzcjjUEwoXU=;
 b=rpYLywZnaMlJmLu9mHyM5dMzeRkzlOGR3mtnEM2wXnEr2w/x7OFBE6vTHX5mq8mmjA
 Cz47b6rzEg1PM+w7yCLri9Q2sJkbq906NkgQGQlrR6TWgfdsnsfisP1309pfRM0Xmwx4
 uEYVhUP93/RQnfNzrm0Ole4HSMaPb3G5nIqMmNUpeYJJm3I9Hn3YdAMI1K8vAczrO1d2
 FgeL699BFqxbXR6maryA7gMtqSwfMSIfpF1iwQ9UaX30Bj7FYvtPca4DM6LZFuqh3jDj
 mxeGzBxK8+Sl2lHUGFpYPSwE7xC878YmG5QuN9hehgpjp/cjaUnTYTJ9tu8khtus/lFo
 Y/xA==
Message-ID: <dc268a07-7b85-6483-da2b-edc5a8f5f3b8@blackwall.org>
Date: Sun, 29 Jan 2023 12:11:49 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <cover.1674752051.git.petrm@nvidia.com>
 <ade8275e8b812248effbfe5249d0116763340b3d.1674752051.git.petrm@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ade8275e8b812248effbfe5249d0116763340b3d.1674752051.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 15/16] selftests: forwarding: lib: Add
 helpers to build IGMP/MLD leave packets
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
> The testsuite that checks for mcast_max_groups functionality will need to
> wipe the added groups as well. Add helpers to build an IGMP or MLD packets
> announcing that host is leaving a given group.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  tools/testing/selftests/net/forwarding/lib.sh | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


