Date: Thu, 31 Jan 2008 03:31:28 -0800 (PST)
From: Alex Shnitman <alexta69@yahoo.com>
Subject: Re: [Bridge] Bridge not functional after disconnect / connect
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <906285.63210.qm@web60421.mail.yahoo.com>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
Cc: bridge@lists.linux-foundation.org

In fact, it's the skge driver. I'll try to upgrade the kernel to 2.6.22 (the latest one available in etch backports) and report the results.

Thanks,
--Alex


----- Original Message ----
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
To: Alex Shnitman <alexta69@yahoo.com>
Cc: Stephen Hemminger <shemminger@linux-foundation.org>; bridge@lists.linux-foundation.org
Sent: Thursday, January 31, 2008 11:59:34 AM
Subject: Re: [Bridge] Bridge not functional after disconnect / connect


At 
00:44 
today, 
Alex 
Shnitman 
wrote:

> 
02:05.0 
Ethernet 
controller: 
Marvell 
Technology 
Group 
Ltd. 
88E8001 
Gigabit 
Ethernet 
Controller 
(rev 
13)

Is 
that 
the 
sky2 
driver?  
That 
is 
in 
my 
experience 
pretty 
buggy 
until 
about 
2.6.22.

-- 
Malcolm 
Scott
Research 
Assistant
University 
of 
Cambridge 
Computer 
Laboratory






      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
