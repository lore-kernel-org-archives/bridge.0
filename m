DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=beta;
	h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
	bh=OQBAZLFa0t/Z0isUme3ihnv4e3jI7BcMQZ2wUl8xPc8=;
	b=kUd88cXPRQ0wwCLx1qlwgDd/V3ovyr0EiU+1Xj6FYYO83SSnAo2Esghmq5PqCZFnvbhuNBA5JsMNEMyoqbgmuahF1tpoo3IakQ2VM0DK7ZnZltURYYyDXulmrYpsxX8L3VCQdYawaDk6uX+ATKxhcwVvaujNyeKhPek00xSGEzg=
Message-ID: <9e0cf0bf0710281323y6e91241fgfa1c2a93ed371430@mail.gmail.com>
Date: Sun, 28 Oct 2007 22:23:27 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Bridge] TCP/IP requirement for bridge-utils
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

I am trying to install TCP/IP-less Linux bridge. I was quite surprised
to see that bridge-utils communicate with kernel via TCP socket.

Since bridge git is not online, I could not check if this have changed
since version 1.2.

I see that there is a sysfs interface, but I am not sure how I can add
new bridge via this interface.

Can the TCP/IP dependency be dropped?

Best Regards,
Alon Bar-Lev.
