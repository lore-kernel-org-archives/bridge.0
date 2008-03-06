Message-ID: <47D05B55.404@operations.com>
Date: Thu, 06 Mar 2008 16:00:05 -0500
From: Lou Steinberg <lspam5@operations.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] bridge-utils and ppp
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi Folks-

Forgive the newbie question, but my attempts to answer this through 
google have left me confused. 

I'm trying to bridge between a pair of ppp and eth interfaces in an 
embedded linux distribution called SlugOS.  The kernel is 2.6.21 and my 
understanding was that the 2.6 kernels have the mods to support ppp 
interfaces.  When I try to add my ppp0 interface to a bridge, I get:
> $ brctl addif test ppp0
> can't add ppp0 to bridge test: Invalid argument

MTUs are set the same for all interfaces.  Is there a specific version 
of the bridge-utils package I need?  The version packed for my 
distribution claims to be 1.2-r0

Thanks in advance,
Lou


