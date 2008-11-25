Message-ID: <20081125153116.42936yyfpzcbl8p0@w0.mail.sapo.pt>
Date: Tue, 25 Nov 2008 15:31:16 +0000
From: =?iso-8859-15?b?Sm/jbw==?= Pedro <countzero@sapo.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; DelSp="Yes"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Bridging VLANs and PVST+
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org


Hello,

Two years ago there was a post regarding a patch to the Linux kernel  
allowing it to bridge of two VLANs with Cisco's PVST+  
(https://lists.linux-foundation.org/pipermail/bridge/2006-May/004921.html). I  
tried contacting both Gergely Madarasz (the author of the patch) and  
Ian Schwimmer (who started the thread) without any luck.

Does anyone has this patch? Or, for that matter, a solution on how to  
do this? I'm currently using ebtables on SLES10SP2 to DROP the  
switch's BPDUs, avoiding it from shutting down the port; I have also  
changed the bridge's ULA in order to use "per-vlan" STP. This  
situation if far from ideal, of course: it would be great to have STP  
working between the Linux box and the Cisco switch (or any other  
switch), allowing it [the Linux Box] to "fail-to-wire" if something  
was to go wrong.

Thank you,
JP
