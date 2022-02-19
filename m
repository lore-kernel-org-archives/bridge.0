Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Y7dI/kyXtQ5r7J/1JCw2+N0TiORB8W3a63ggFTECDo4=;
 b=ZA9bzecfezxlqpIiccEI1K27SXLtnJUjvIEbkbGMkLbgdFc1iGqVU85mJgKlmd27Ss
 HiozbCv7C4S2YiTIssUYYUrd0zqxKkMq6vZp4b0cc50nSW9sRoZd1xATLPxnA8jK7wLF
 XY4FIbMD9X2B0LBasRTc3GMGMw8dHw1M9eL8AFSUBju46diRXcQtCFpV7+jUvB5E5N9i
 1XzzVYYVTWtDWd5gJTGboaBXVKZYhalyZNB8qRLe/rMs4QA5+LG75iWuzuV+EEGww2Ua
 pYVu/YUJK7gKO3hNz6QCVJP9y7Bybqbrbr980TjsvqkWiuKlhznug6XWMkd5seDCAUXf
 u5Dw==
Date: Sat, 19 Feb 2022 11:56:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220219095649.zaa7exduogwbpyyh@skbuf>
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
 <20220218155148.2329797-4-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218155148.2329797-4-schultz.hans+netdev@gmail.com>
Subject: Re: [Bridge] [PATCH net-next v3 3/5] net: dsa: Add support for
 offloaded locked port flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Fri, Feb 18, 2022 at 04:51:46PM +0100, Hans Schultz wrote:
> Among the switchcores that support this feature is the Marvell
> mv88e6xxx family.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

Although this doesn't "add support for offloaded locked ports", that
passes right through with no DSA-level filtering, from
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS to dsa_port_bridge_flags(),
to ds->ops->port_bridge_flags().

Rather, a clearer description of what this does is:

net: dsa: include BR_PORT_LOCKED in the list of synced brport flags

Make sure the DSA switch driver gets notified of changes to the
BR_PORT_LOCKED flag as well, for the case when a DSA port joins or
leaves a LAG that is a bridge port.
