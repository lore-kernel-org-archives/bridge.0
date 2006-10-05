Message-ID: <8cbd14710610050226g2aaf9428xfac7a3cccdc30f18@mail.gmail.com>
Date: Thu, 5 Oct 2006 14:56:13 +0530
From: Skept <impossibleprobability@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: Re: [Bridge] Bridge Woes
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

see if the interfaces attached to the bridge interface are up. if not, try

ip link set dev eth0 up
ip link set dev eth1 up
