Message-ID: <44408207.1070404@osdl.org>
Date: Fri, 14 Apr 2006 22:17:59 -0700
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
References: <20060414235008.66335.qmail@web52913.mail.yahoo.com>
In-Reply-To: <20060414235008.66335.qmail@web52913.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: No UDP NFS over bridges in Linux 2.6.16.x?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Chris Rankin <rankincj@yahoo.com>
Cc: nfs@lists.sourceforge.net, bridge@osdl.org

Then get a packet trace of a failing session with tcpdump. You may need 
to get two, one
one the client and one on the server to be able to see which packet 
isn't getting past the
bridge.

There are tools to santize tcpdump files if you are paranoid about IP 
adresses, etc.
