Message-ID: <43AEE0D3.9070705@osdl.org>
Date: Sun, 25 Dec 2005 10:11:31 -0800
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Subject: Re: [Bridge] When I add br0 (brctl addbr br0), and I show bridge
	list  (brctl show) it's eth0 which is in the list. It's a bug ?
References: <dolu7k$anu$1@sea.gmane.org>
In-Reply-To: <dolu7k$anu$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: =?ISO-8859-1?Q?KLEIN_St=E9phane?= <stephane@harobed.org>
Cc: bridge@osdl.org

What is the hardware address of your eth0?
It looks like it is 00:00:00:00:00:00 which implies a hardware
problem?

Look at 'ifconfig eth0' output
