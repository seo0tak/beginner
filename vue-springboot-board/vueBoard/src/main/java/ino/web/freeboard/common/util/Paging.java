package ino.web.freeboard.common.util;

public class Paging {
	public static final int pageScale = 10; // 페이지당 게시물 수
	public static final int blockScale = 10; // 화면당 페이지 수
	
	private int curPage; //현재 페이지
	private int prevPage; //이전 페이지
	private int nextPage; //다음 페이지
	private int totalPage; //전체 페이지 개수
	private int totBlock; // 전체 페이지 블록 갯수
	private int curBlock; // 현재 페이지 블록
	private int prevBlock; // 이전 페이지 블록
	private int nextBlock; // 다음 페이지 블록
	private int pageBegin; // #{start}
	private int pageEnd; // #{end}
	private int blockBegin; // 현재페이지 블록의 시작번호
	private int blockEnd; // 현재페이지 블록의 끝번호
	
	
	public Paging(int count, int curPage) {
		curBlock = 1; // 현재 페이지 블록 번호
		this.curPage = curPage; // 현재 페이지 설정
		setTotalPage(count); // 전체 페이지 갯수 계산
		setPageRange(); // 시작번호 끝번호 
		setTotBlock(); // 전체 페이지 블록 갯수 계산
		setBlockRange(); // 페이지의 블록의 시작,끝 번호 계산
	}
	
	public void setBlockRange() {
		//현재 페이지가 몇번째 페이지 블록에 속하는 계산
		curBlock = (int)Math.ceil((curPage-1) / blockScale)+1;
		// 현재 페이지 블록의 시작, 끝 번호 계산
		blockBegin = (curBlock-1)*blockScale+1;
		// 페이지 블록의 끝 번호
		blockEnd = blockBegin+blockScale-1;
		// 마지막 블록이 범위를 초과하지 않도록 계산
		if(blockEnd > totalPage) blockEnd = totalPage;
		// 이전을 눌렀을 때 이동할 페이지 번호
		prevPage = (curPage == 1) ? 1 : (curBlock-1)*blockScale;
		// 다음을 눌렀을 때 이동할 페이지 번호
		nextPage = curBlock > totBlock ? (curBlock*blockScale) : (curBlock*blockScale)+1;
		// 마지막 페이자가 범위를 초과 하지 않도록 처리
		if(nextPage >= totalPage) nextPage = totalPage;
	}

	public void setPageRange() {
		pageBegin = (curPage-1)*pageScale+1; 
		pageEnd = pageBegin+pageScale-1;
	}

	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getTotalPage() {
		return totalPage;
	}
	//페이지 블록 갯수 계산
	public void setTotalPage(int count) {
		totalPage = (int)Math.ceil( count*1.0 / pageScale);
	}

	public int getTotBlock() {
		return totBlock;
	}
	// 전체 페이지 갯수 계산
	public void setTotBlock() {
		totBlock = (int)Math.ceil(totalPage / blockScale);
	}

	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getPrevBlock() {
		return prevBlock;
	}

	public void setPrevBlock(int prevBlock) {
		this.prevBlock = prevBlock;
	}

	public int getNextBlock() {
		return nextBlock;
	}

	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}

	public int getPageBegin() {
		return pageBegin;
	}

	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public int getBlockBegin() {
		return blockBegin;
	}

	public void setBlockBegin(int blockBegin) {
		this.blockBegin = blockBegin;
	}

	public int getBlockEnd() {
		return blockEnd;
	}

	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}
	
}
