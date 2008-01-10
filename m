Date: Thu, 10 Jan 2008 14:55:55 +0000 (GMT)
From: Malcolm Scott <Malcolm.Scott@cl.cam.ac.uk>
Subject: Re: [Bridge] cannot ping network when i do addif br0 eth0
In-Reply-To: <47862D4A.40806@kiusys.com>
Message-ID: <alpine.DEB.1.00.0801101455260.14271@callisto.moose.malc.org.uk>
References: <47862D4A.40806@kiusys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ivan Hernandez <ihernandez@kiusys.com>
Cc: bridge@lists.linux-foundation.org

At 12:35 today, Ivan Hernandez wrote:

> some tip to use my eth0 card while it's on the bridge?

You should add your IP address to the bridge interface (br0) rather than 
eth0.

-- 
Malcolm Scott
Research Assistant
University of Cambridge Computer Laboratory

