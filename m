Message-ID: <4602BB71.2010002@mindspeed.com>
Date: Thu, 22 Mar 2007 10:22:57 -0700
From: Wade Guthrie <wade.guthrie@mindspeed.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bridge] I want to RTFM -- so where's the FM?
Reply-To: wade.guthrie@mindspeed.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

Hi all,

I'm looking for documentation about the internals of the bridging 
software.  We're putting together a new chip that incorporates, among 
other things, a core for a managed switch and a processor that will be 
running Linux.  I wanted to have the Linux code (among other things) 
field SNMP requests and configure the managed switch.  I'm hoping that 
it's as simple as writing a driver for the managed switch and 
registering it with the bridging code.  Is there any documentation on 
the internals of the bridging software or do I have to paw through the 
source?

Thanks!

-- 
Wade Guthrie
wade.guthrie@mindspeed.com

