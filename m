Message-ID: <4607F4FE.1080507@candelatech.com>
Date: Mon, 26 Mar 2007 09:29:50 -0700
From: Ben Greear <greearb@candelatech.com>
MIME-Version: 1.0
References: <34d8b2fe0703260548k4d39e491hf6ec324297635dfe@mail.gmail.com>
In-Reply-To: <34d8b2fe0703260548k4d39e491hf6ec324297635dfe@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] How to test vlan tag under Linux
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Louis Croisez <louis.croisez@gmail.com>
Cc: bridge@lists.osdl.org

Louis Croisez wrote:
> Hello all,
> i would like to build a setup to generate VLAN frames (respecting the
> IEEE 802.1Q standard) for testing purpose.
> How to configure a Linux bridge for it to become a VLAN switch?
> Is it possible?
> What user tool to use for that? brctl?

Try 'vconfig' assuming you have a relatively modern
distribution.  More info is here:

http://www.candelatech.com/~greear/vlan.html

Thanks,
Ben

> 
> Regards,
> Louis
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

