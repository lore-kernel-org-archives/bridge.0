Date: Thu, 22 Mar 2007 11:27:00 -0700
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20070322112700.5bbc6ba1@freekitty>
In-Reply-To: <4602BB71.2010002@mindspeed.com>
References: <4602BB71.2010002@mindspeed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] I want to RTFM -- so where's the FM?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: wade.guthrie@mindspeed.com
Cc: bridge@lists.linux-foundation.org

On Thu, 22 Mar 2007 10:22:57 -0700
Wade Guthrie <wade.guthrie@mindspeed.com> wrote:

> Hi all,
> 
> I'm looking for documentation about the internals of the bridging 
> software.  We're putting together a new chip that incorporates, among 
> other things, a core for a managed switch and a processor that will be 
> running Linux.  I wanted to have the Linux code (among other things) 
> field SNMP requests and configure the managed switch.  I'm hoping that 
> it's as simple as writing a driver for the managed switch and 
> registering it with the bridging code.  Is there any documentation on 
> the internals of the bridging software or do I have to paw through the 
> source?
> 
> Thanks!
> 

Obvious places:
	Linux net wiki	http://linux-net.osdl.org
	Documentation/networking/* in kernel sources
	manual pages in bridge-utils
	

-- 
Stephen Hemminger <shemminger@linux-foundation.org>
