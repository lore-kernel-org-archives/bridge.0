Message-ID: <42791696.7090106@purdue.edu>
Date: Wed, 04 May 2005 13:38:14 -0500
From: Roman Chertov <rchertov@purdue.edu>
MIME-Version: 1.0
Subject: Re: [Bridge] Introducing latency
References: <EDF30175FE4D804B83444FB153172A50509A4D@louexch.KiZAN.net>
In-Reply-To: <EDF30175FE4D804B83444FB153172A50509A4D@louexch.KiZAN.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Jeff Gercken <JeffG@kizan.com>
Cc: bridge@lists.osdl.org

Jeff Gercken wrote:
> Does anyone know how I might introduce latency on the packets that I
> bridge?  I'm trying to develop a system for simulating wan links and
> often bandwidth isn't as big an issue as delay, especially when talking
> wireless (dot11 or satellite).

You can use the dummynet of the ipfw in FreeBSD to add delays/link 
limitations/loss.  You can also create a bridge with ipfw as well.  I am 
not sure what Linux has for traffic shaping.

Roman

> 
> Thanks,
> jeff
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> http://lists.osdl.org/mailman/listinfo/bridge
