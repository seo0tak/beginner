import http from "../http-common";

class BoardDataService {
  getAll(curPage) {
    return http.get('/vueBoard?curPage='+curPage);
  }

  get(num) {
    return http.get(`/vueBoard/${num}`);
  }

  create(data) {
    return http.post("/vueBoard", data);
  }

  update(num, data) {
    return http.put(`/vueBoard/${num}`, data);
  }

  delete(num) {
    return http.delete(`/vueBoard/${num}`);
  }

}

export default new BoardDataService();