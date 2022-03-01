Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9x7bVbTmKslH1o+b4w0DypYAmuXcIYWDpO7m/YGx0Qo=;
 b=T6MithCuHZshlDV57jTTWmaPRQiWB3Vu51iHZzs9uMkcD2KiIU0O8SEm0Mud/Bk9q0
 bi+xar/dppgJyefJgnB3QJEKbrup7tlgIr6fmM1v5voTNVSaRIVfJRI4fP7nkTnMgH+j
 lUFrsIQiNbBrT8sPzecjb+GCGn10inOHFOJlT73U1370WeR3SB42d17B+7ZybP++fCIb
 teBW+ABfyi0ogU9O11SabHkjMOeQ0Uv24M1sHgolj+ES6we7hf96BzHiAMWkMSH7hgy+
 Mqf6/n10dJpSgUc521cRXCRKMJn7kUNwDeDN7yT+Ky+j1W/ze+x+1LaU2ijtn2oXJzAt
 0oQQ==
Date: Tue, 1 Mar 2022 09:19:59 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20220301091959.4c8a893b@hermes.local>
In-Reply-To: <20220301162142.2rv23g4cyd2yacbs@skbuf>
References: <20220301100321.951175-1-tobias@waldekranz.com>
 <20220301162142.2rv23g4cyd2yacbs@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 00/10] net: bridge: Multiple
	Spanning Trees
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org, Tobias Waldekranz <tobias@waldekranz.com>

On Tue, 1 Mar 2022 18:21:42 +0200
Vladimir Oltean <olteanv@gmail.com> wrote:

> Hi Tobias,
> 
> On Tue, Mar 01, 2022 at 11:03:11AM +0100, Tobias Waldekranz wrote:
> > A proposal for the corresponding iproute2 interface is available here:
> > 
> > https://github.com/wkz/iproute2/tree/mst  
> 
> Please pardon my ignorance. Is there a user-mode STP protocol application
> that supports MSTP, and that you've tested these patches with?
> I'd like to give it a try.

https://github.com/mstpd/mstpd
